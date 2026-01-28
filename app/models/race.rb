class Race < ApplicationRecord
  with_options dependent: :destroy do
    has_many :race_proficiencies
    has_many :race_proficiency_choices
    has_many :trait_races
    has_many :race_ability_bonus, class_name: 'RaceAbilityBonus'
    has_many :race_ability_bonus_choices
    has_many :race_languages
    has_many :race_language_choices
    has_many :subraces
  end

  has_many :proficiencies, -> { distinct }, through: :race_proficiencies
  has_many :proficiency_options, through: :race_proficiency_choices, source: :race_proficiency_choice_options

  has_many :traits, -> { distinct }, through: :trait_races

  has_many :ability_scores, -> { distinct }, through: :race_ability_bonus
  has_many :ability_bonus_options, through: :race_ability_bonus_choices, source: :race_ability_bonus_choice_options

  has_many :languages, -> { distinct }, through: :race_languages
  has_many :language_options, through: :race_language_choices, source: :race_language_choice_options

  def ability_bonus_summary
    race_ability_bonus.includes(:ability_score).each_with_object({}) do |bonus, summary|
      next unless bonus.ability_score

      summary[bonus.ability_score.full_name] = bonus.bonus
    end
  end

  def ancestry_traits
    traits
  end
end
