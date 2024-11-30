class Klass < ApplicationRecord
  has_many :class_proficiencies
  has_many :proficiencies, through: :class_proficiencies
end
