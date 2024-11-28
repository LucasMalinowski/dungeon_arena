class CreateMagicalItems < ActiveRecord::Migration[7.1]
  def change
    create_table :magical_items do |t|
      t.string :name
      t.string :cost_unity
      t.integer :cost_quantity
      t.integer :weight
      t.text :description
      t.string :rarity
      t.boolean :variant
      t.string :variants
      t.references :equipment_categories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
