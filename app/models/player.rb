class Player < ActiveRecord::Base
  attr_accessible :name, :phone, :event_id, :start_time, :end_time, :user_passes, :accepted

  has_many :event_prompts, dependent: :destroy
  has_many :prompts, through: :event_prompts
  belongs_to :event

  before_save :format_phone_number
  # east to add RSPEC to this


  validates :name, presence: true
  validates :phone, presence: true
  validates :event_id, presence: true
  #validates :phone, :phone_number => {:ten_digits => true}
  # validates :start_time, presence: true
  # validates :end_time, presence: true


  def format_phone_number
    number = self.phone

    unless number[0..1] == "+1"
      number.gsub!(/[^0-9]/, '')
      self.phone = "+1#{number}"
    end
  end


  def get_new_prompt
    # create a new event_prompt
    new_event_prompt = self.event_prompts.new

    # set the prompt equal to a random prompt (that fits the event criteria)
    new_event_prompt.prompt = self.event.random_prompt

    # set the event equal to the player's event
    new_event_prompt.event = self.event

    # save the new event_prompt
    new_event_prompt.save

    # respond to the user with the message from the event_prompt we added
    self.event_prompts.last.prompt.description
  end

  def accept_invite
    start_time = Time.now
    self.update_attributes(accepted: true, start_time: start_time)
  end

  def self.create_by_passphrase(event, phone)
    self.create(name: "passphrase_joiner", phone: phone, event_id: event.id)
  end

  def send_text(text)
    account_sid    = ENV["account_sid"]
    auth_token     = ENV["auth_token"]
    client = Twilio::REST::Client.new account_sid, auth_token

    account = client.account
    message = account.sms.messages.create({
      :from => '+16018034035',
      :to => self.phone,
      :body => text})
    puts message
  end

end


