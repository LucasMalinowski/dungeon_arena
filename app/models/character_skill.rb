class CharacterSkill < ApplicationRecord
  belongs_to :character
  belongs_to :skill

  validates :proficiency, numericality: { greater_than_or_equal_to: 0 }
end
