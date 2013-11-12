class PartyType < ActiveRecord::Base
  attr_accessible :description

  has_many :party_type_prompts, dependent: :destroy
  has_many :prompts, through: :party_type_prompts
  has_many :events

  validates :description, presence: true
end
