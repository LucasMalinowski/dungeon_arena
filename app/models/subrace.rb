class Subrace < ApplicationRecord
  belongs_to :race

  has_many :trait_subraces, dependent: :destroy, class_name: 'TraitSubrace'
  has_many :traits, through: :trait_subraces

  has_many :subrace_proficiencies, dependent: :destroy, class_name: 'SubraceProficiency'
  has_many :proficiencies, through: :subrace_proficiencies

  has_many :subrace_ability_bonus, dependent: :destroy, class_name: 'SubraceAbilityBonus'
  has_many :ability_scores, through: :subrace_ability_bonus

  has_many :subrace_language_choices, dependent: :destroy, class_name: 'SubraceLanguageChoice'
  has_many :language_options, through: :subrace_language_choices, source: :subrace_language_choice_options
end
