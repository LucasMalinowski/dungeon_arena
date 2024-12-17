class FixMinorBugs < ActiveRecord::Migration[7.1]
  def change
    change_column_null :features, :subclass_id, true
    drop_table :characters
  end
end
