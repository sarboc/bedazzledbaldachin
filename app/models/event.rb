class Event < ActiveRecord::Base
  attr_accessible :end_time, :user_id, :event_status, :rating_id, :start_time, :wordnik, :party_type_id

  has_many :players, dependent: :destroy
  has_many :event_prompts, dependent: :destroy
  has_many :prompts, through: :event_prompts
  belongs_to :rating
  belongs_to :party_type
  belongs_to :user

  validates :rating_id, presence: true
  validates :party_type_id, presence: true

  # after_create :add_start_end_time
  before_create :add_wordnik

  def start
    # set start time to now
    self.start_time = Time.now
    self.end_time = self.start_time + 60 * 60 * 3
    self.event_status = true
    self.save

    # iterate through accepted players, sending the first prompt to each - the Party Starter!
    self.players.where("accepted is true").each do |player|
      player.send_text("#{player.get_new_prompt} Respond with 'd' when done or 'p' to pass.")
    end
  end

  def end
    self.end_time = Time.now
    self.event_status = false
    self.players.where("end_time is null").each do |player|
      player.update_attributes(end_time: Time.now)
    end
    self.save
    # set end time for any open players
  end

  def add_wordnik

    # get two random words from wordnik
    word1 = get_random_word
    word2 = get_random_word

    # check to make sure they aren't the same word
    # get a new second word if they're the same
    while word1 == word2
      word2 = get_random_word
    end

    # sets the wordnik phrase for this party to a string of word1 + word2
    self.wordnik = "#{word1.downcase} #{word2.downcase}"
  end

  def get_random_word
    # gets a random Wordnik word with the following options:
    # maxLength: 7 - sets the query to pull only words 7 letters or fewer
    # includePartsOfSpeech: "noun" - calls only nouns
    # excludePartsOfSpeech: "proper-noun" - excludes proper nouns, such as "Paul"
    # excludePartsOfSpeech: "proper-noun-plural" - excludes plural proper nouns such as "Steves"
    # excludePartsOfSpeech: "proper-noun-possessive" - excludes possessive proper nouns such as "Steve's"
    # result is a hash, and we want the value of the ["word"] key
    Wordnik.words.get_random_word(maxLength: 7, includePartOfSpeech: "noun", excludePartOfSpeech: "proper-noun", excludePartOfSpeech: "proper-noun-plural", excludePartOfSpeech: "proper-noun-posessive")["word"]
  end


  # def add_user_id
  #   self.user_id = current_user.id
  # end

  def random_prompt
    # find prompts based on party type
    # where prompt.rating.value <= self.rating.value
    self.party_type.prompts.joins(:rating).where("ratings.value <= ?", self.rating.value).sample
  end

end
