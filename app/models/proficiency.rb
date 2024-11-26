class Proficiency < ApplicationRecord
  has_many :class_proficiencies, dependent: :destroy
  has_many :klasses, through: :class_proficiencies
end
