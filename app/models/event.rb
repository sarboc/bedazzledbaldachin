class Event < ActiveRecord::Base
  attr_accessible :end_time, :event_status, :rating_id, :start_time, :wordnik, :party_type_id

  has_many :players, dependent: :destroy
  has_many :event_prompts, dependent: :destroy
  has_many :prompts, through: :event_prompts
  belongs_to :rating
  belongs_to :party_type
  belongs_to :user

  validates :rating_id, presence: true
  validates :wordnik, presence: true
  validates :party_type_id, presence: true
end
