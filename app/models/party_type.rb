class PartyType < ActiveRecord::Base
  attr_accessible :description

  has_many :party_type_prompts
  has_many :prompts, through: :party_type_prompts

  validates :description, presence: true
end
