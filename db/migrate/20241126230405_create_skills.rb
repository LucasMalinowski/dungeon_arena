class CreateSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :skills do |t|
      t.string :name
      t.text :description
      t.references :ability_score, null: false, foreign_key: true

      t.timestamps
    end
  end
end
