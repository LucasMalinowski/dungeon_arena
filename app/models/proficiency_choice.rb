class ProficiencyChoice < ApplicationRecord
  belongs_to :klass, optional: true
  has_many :proficiency_choice_options
end
