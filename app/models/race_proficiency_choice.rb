class RaceProficiencyChoice < ApplicationRecord
  belongs_to :race
  has_many :race_proficiency_choice_options
end
