class Condition < ApplicationRecord
  has_many :monster_condition_immunities, dependent: :destroy
  has_many :immune_monsters, through: :monster_condition_immunities, source: :monster
end
