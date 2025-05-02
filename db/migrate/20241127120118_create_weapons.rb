class CreateWeapons < ActiveRecord::Migration[7.1]
  def change
    create_table :weapons do |t|
      t.string :name
      t.string :weapon_category
      t.string :weapon_range
      t.string :category_range
      t.string :damage_dice
      t.string :two_hand_damage_dice
      t.integer :normal_range
      t.integer :long_range
      t.string :cost_unity
      t.integer :cost_quantity
      t.integer :weight
      t.string :special
      t.integer :throw_range_normal
      t.integer :throw_range_long
      t.references :equipment_categories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
