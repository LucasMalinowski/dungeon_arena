class Race < ApplicationRecord
  has_many :race_proficiencies
  has_many :proficiencies, through: :race_proficiencies
end
