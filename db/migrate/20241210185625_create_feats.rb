class CreateFeats < ActiveRecord::Migration[7.1]
  def change
    create_table :feats do |t|
      t.string :name
      t.string :description
      t.integer :minimum_score
      t.references :ability_score, null: true, foreign_key: true

      t.timestamps
    end
  end
end
