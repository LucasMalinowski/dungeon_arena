class ProficiencyChoice < ApplicationRecord
  belongs_to :klass, optional: true
  has_many :proficiency_choice_options
  has_many :proficiencies, through: :proficiency_choice_options
end
