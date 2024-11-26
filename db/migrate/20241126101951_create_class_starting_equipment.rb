class CreateClassStartingEquipment < ActiveRecord::Migration[7.1]
  def change
    create_table :class_starting_equipments do |t|
      t.references :klass, null: false, foreign_key: { to_table: :klasses }
      t.references :equipment, null: false, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
