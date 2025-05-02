class CreateAlignments < ActiveRecord::Migration[7.1]
  def change
    create_table :alignments do |t|
      t.string :name
      t.string :abbreviation
      t.text :desc

      t.timestamps
    end
  end
end
