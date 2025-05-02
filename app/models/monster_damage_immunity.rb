class MonsterDamageImmunity < ApplicationRecord
  belongs_to :monster
  belongs_to :damage_type, optional: true
end
