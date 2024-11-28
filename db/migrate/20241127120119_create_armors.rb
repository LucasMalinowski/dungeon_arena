class CreateArmors < ActiveRecord::Migration[7.1]
  def change
    create_table :armors do |t|
      t.string :name
      t.integer :armor_class
      t.string :armor_class_bonus
      t.string :cost_unity
      t.string :armor_category
      t.integer :cost_quantity
      t.integer :weight
      t.boolean :stealth_disadvantage
      t.integer :strength_requirement
      t.references :equipment_categories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
