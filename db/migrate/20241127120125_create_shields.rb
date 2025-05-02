class CreateShields < ActiveRecord::Migration[7.1]
  def change
    create_table :shields do |t|
      t.string :name
      t.integer :armor_class
      t.string :armor_class_bonus
      t.string :cost_unity
      t.integer :cost_quantity
      t.integer :weight
      t.text :description
      t.boolean :stealth_disadvantage
      t.integer :strength_requirement
      t.string :rarity
      t.boolean :variant
      t.string :variants
      t.references :equipment_categories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
