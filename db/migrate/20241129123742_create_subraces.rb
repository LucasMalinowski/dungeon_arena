class CreateSubraces < ActiveRecord::Migration[7.1]
  def change
    create_table :subraces do |t|
      t.string :name
      t.references :race, foreign_key: true

      t.timestamps
    end
  end
end
