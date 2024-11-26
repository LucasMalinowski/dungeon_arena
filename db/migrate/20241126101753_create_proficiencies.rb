class CreateProficiencies < ActiveRecord::Migration[7.1]
  def change
    create_table :proficiencies do |t|
      t.string :index, null: false
      t.string :name, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
