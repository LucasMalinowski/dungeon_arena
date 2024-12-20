class CharacterAbilityScore < ApplicationRecord
  belongs_to :character

  validates :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, presence: true

  def total_modifier(ability_score)
    (ability_score - 10) / 2
  end
end
