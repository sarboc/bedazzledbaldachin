class PartyTypePrompt < ActiveRecord::Base
  attr_accessible :party_type_id, :prompt_id

  belongs_to :party_type
  belongs_to :prompt

  validates :party_type_id, presence: true
end
