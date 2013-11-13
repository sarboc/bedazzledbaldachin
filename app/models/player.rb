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
end
