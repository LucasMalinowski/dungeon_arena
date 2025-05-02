class DamageType < ApplicationRecord
  has_many :weapon_damage_types, dependent: :destroy, class_name: "WeaponDamageTypes"
  has_many :weapons, through: :weapon_damage_types

  has_many :monster_damage_vulnerabilities, dependent: :destroy
  has_many :vulnerable_monsters, through: :monster_damage_vulnerabilities, source: :monster

  has_many :monster_damage_resistances, dependent: :destroy
  has_many :resistant_monsters, through: :monster_damage_resistances, source: :monster

  has_many :monster_damage_immunities, dependent: :destroy
  has_many :immune_monsters, through: :monster_damage_immunities, source: :monster
end
