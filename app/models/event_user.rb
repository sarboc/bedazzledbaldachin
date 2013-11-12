class EventUser < ActiveRecord::Base
  attr_accessible :user_id, :event_id, :start_time, :end_time, :user_passes, :accepted

  has_many :event_prompts
  has_many :prompts, through: :event_prompts
  belongs_to :event
  belongs_to :user

  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_uniqueness_of :user_id, scope: :event_id

end
