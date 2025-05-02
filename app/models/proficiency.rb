class Proficiency < ApplicationRecord
  has_many :class_proficiencies, dependent: :destroy
  has_many :klasses, through: :class_proficiencies

  has_many :race_proficiencies, dependent: :destroy
  has_many :races, through: :race_proficiencies

  has_many :subrace_proficiencies
  has_many :subraces, through: :subrace_proficiencies

  has_many :background_proficiencies, dependent: :destroy
  has_many :backgrounds, through: :background_proficiencies

  has_many :multiclassing_proficiencies, dependent: :destroy
  has_many :multiclassings, through: :multiclassing_proficiencies
end
