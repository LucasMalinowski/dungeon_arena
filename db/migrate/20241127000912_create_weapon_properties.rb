class CreateWeaponProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :weapon_properties do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
