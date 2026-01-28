class Subrace < ApplicationRecord
  belongs_to :race

  with_options dependent: :destroy do
    has_many :trait_subraces, class_name: 'TraitSubrace'
    has_many :subrace_proficiencies, class_name: 'SubraceProficiency'
    has_many :subrace_ability_bonus, class_name: 'SubraceAbilityBonus'
    has_many :subrace_language_choices, class_name: 'SubraceLanguageChoice'
  end

  has_many :traits, -> { distinct }, through: :trait_subraces
  has_many :proficiencies, -> { distinct }, through: :subrace_proficiencies
  has_many :ability_scores, -> { distinct }, through: :subrace_ability_bonus
  has_many :language_options, through: :subrace_language_choices, source: :subrace_language_choice_options

  def ancestry_traits
    traits
  end
end
