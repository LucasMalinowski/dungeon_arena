class MonsterConditionImmunity < ApplicationRecord
  belongs_to :monster
  belongs_to :condition
end
