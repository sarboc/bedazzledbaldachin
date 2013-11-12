class Rating < ActiveRecord::Base
  attr_accessible :name, :value

  has_many :events
  has_many :prompts

  validates :name, presence: true
  validates :value, presence: true
end
