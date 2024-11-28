class CreateEquipment < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment do |t|
      t.string :name
      t.references :equipmentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
