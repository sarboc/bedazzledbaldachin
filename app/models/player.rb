class Player < ActiveRecord::Base
  attr_accessible :name, :phone, :event_id, :start_time, :end_time, :user_passes, :accepted

  has_many :event_prompts, dependent: :destroy
  has_many :prompts, through: :event_prompts
  belongs_to :event

  validates :name, presence: true
  validates :phone, presence: true
  validates :event_id, presence: true
  # validates :start_time, presence: true
  # validates :end_time, presence: true


  after_create :add_start_end_time

  def add_start_end_time
    self.start_time = Time.now
    self.end_time = self.start_time + 60 * 60 * 3
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
end
