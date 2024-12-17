class TraitProficiencyChoice < ApplicationRecord
  belongs_to :trait
  has_many :trait_proficiency_choice_options, dependent: :destroy
end
