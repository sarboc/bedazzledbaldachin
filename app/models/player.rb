class Player < ActiveRecord::Base
  attr_accessible :name, :phone, :event_id, :start_time, :end_time, :user_passes, :accepted

  has_many :event_prompts, dependent: :destroy
  has_many :prompts, through: :event_prompts
  belongs_to :event

  validates :name, presence: true
  validates :phone, presence: true
  validates :event_id, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

end
