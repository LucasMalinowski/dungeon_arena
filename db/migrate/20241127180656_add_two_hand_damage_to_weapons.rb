class AddTwoHandDamageToWeapons < ActiveRecord::Migration[7.1]
  def change
    create_table :weapon_property_weapons do |t|
      t.belongs_to :weapon_property, index: true
      t.belongs_to :weapon, index: true
    end

    create_table :weapon_damage_types do |t|
      t.belongs_to :weapon, index: true
      t.belongs_to :damage_type, index: true
      t.string :damage_instance
    end
  end
end
