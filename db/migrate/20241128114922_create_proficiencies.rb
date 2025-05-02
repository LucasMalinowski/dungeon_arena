class CreateProficiencies < ActiveRecord::Migration[7.1]
  def change
    create_table :proficiencies do |t|
      t.string :name

      t.timestamps
    end
  end
end
