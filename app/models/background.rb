class Background < ApplicationRecord
  has_many :background_proficiencies, dependent: :destroy
  has_many :proficiencies, through: :background_proficiencies

  has_many :background_personality_trait_choices, dependent: :destroy
  has_many :background_personality_trait_choice_options, through: :background_personality_trait_choices

  has_many :background_ideal_choices, dependent: :destroy
  has_many :background_ideal_choice_options, through: :background_ideal_choices
  has_many :background_ideal_option_alignment, through: :background_ideal_choice_options

  has_many :background_flaw_choices, dependent: :destroy
  has_many :background_flaw_choice_options, through: :background_flaw_choices

  has_many :background_bond_choices, dependent: :destroy
  has_many :background_bond_choice_options, through: :background_bond_choices
end
