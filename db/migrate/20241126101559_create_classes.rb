class CreateClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :klasses do |t|
      t.string :index, null: false
      t.string :name, null: false
      t.integer :hit_die, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
