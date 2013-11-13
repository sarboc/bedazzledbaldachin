class Event < ActiveRecord::Base
  attr_accessible :end_time, :event_status, :rating_id, :start_time, :wordnik, :party_type_id

  has_many :players, dependent: :destroy
  has_many :event_prompts, dependent: :destroy
  has_many :prompts, through: :event_prompts
  belongs_to :rating
  belongs_to :party_type
  belongs_to :user

  validates :rating_id, presence: true
  validates :party_type_id, presence: true

  after_create :add_start_end_time
  after_create :add_wordnik

  def add_start_end_time
    # set start time to now
    self.start_time = Time.now

    # set end time to now plus 3 hours
    self.end_time = self.start_time + 60 * 60 * 3
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
    self.wordnik = "#{word1} #{word2}"

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

end
