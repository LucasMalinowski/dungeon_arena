class CreateRacesAndRacesProficiencies < ActiveRecord::Migration[7.1]
  def change
    create_table :races do |t|
      t.string :name

      t.timestamps
    end

    create_table :race_proficiencies do |t|
      t.references :race, foreign_key: true
      t.references :proficiency, foreign_key: true
    end
  end
end
