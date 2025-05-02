class CharacterClass < ApplicationRecord
  belongs_to :character
  belongs_to :klass

  validates :level, numericality: { greater_than_or_equal_to: 1 }
end
