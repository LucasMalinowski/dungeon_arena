class CreateMounts < ActiveRecord::Migration[7.1]
  def change
    create_table :mounts do |t|
      t.string :name
      t.string :cost_unity
      t.integer :cost_quantity
      t.integer :weight
      t.integer :speed
      t.string :speed_unity
      t.string :carry_capacity
      t.text :description
      t.references :equipment_categories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
