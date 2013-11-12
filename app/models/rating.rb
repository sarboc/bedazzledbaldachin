class Rating < ActiveRecord::Base
  attr_accessible :name, :value

  belongs_to :event
  belongs_to :prompt

  validates :name, presence: true
  validates :value, presence: true
end
