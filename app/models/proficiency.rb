class Proficiency < ApplicationRecord
  has_many :class_proficiencies, dependent: :destroy
  has_many :klasses, through: :class_proficiencies
  has_many :race_proficiencies, dependent: :destroy
  has_many :races, through: :race_proficiencies
end
