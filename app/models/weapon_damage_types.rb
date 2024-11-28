class WeaponDamageTypes < ApplicationRecord
  belongs_to :weapon
  belongs_to :damage_type
end
