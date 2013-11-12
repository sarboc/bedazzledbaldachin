class Prompt < ActiveRecord::Base
  attr_accessible :category_type, :description, :rating_id, :requirements

  has_many :party_type_prompts, dependent: :destroy
  has_many party_types:, through: :party_type_prompts
  belongs_to :event_prompts
  belongs_to :rating

  validates :description, presence: true
  validates :category_type, presence: true
  validates :requirements, presence: true

end
