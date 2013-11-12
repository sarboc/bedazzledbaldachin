class Event < ActiveRecord::Base
  attr_accessible :end_time, :event_status, :rating_id, :start_time, :wordnik

  belongs_to :event_user
  belongs_to :rating
  has_many :event_prompts
  has_one :party_type

  validates :rating_id, presence: true
  validates :wordnik, presence: true

end
