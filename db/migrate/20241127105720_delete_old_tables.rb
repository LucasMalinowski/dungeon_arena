class DeleteOldTables < ActiveRecord::Migration[7.1]
  def change
    drop_table :class_proficiencies
    drop_table :class_saving_throws
    drop_table :class_starting_equipments
    drop_table :equipment
    drop_table :proficiencies
    drop_table :saving_throws
  end
end
