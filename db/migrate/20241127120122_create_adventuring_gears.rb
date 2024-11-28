class CreateAdventuringGears < ActiveRecord::Migration[7.1]
  def change
    create_table :adventuring_gears do |t|
      t.string :name
      t.string :cost_unity
      t.integer :cost_quantity
      t.integer :weight
      t.string :gear_category
      t.text :description
      t.references :equipment_categories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
