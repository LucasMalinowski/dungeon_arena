class CreateEquipmentCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
