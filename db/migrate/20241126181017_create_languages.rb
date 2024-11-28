class CreateLanguages < ActiveRecord::Migration[7.1]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :language_type
      t.string :typical_speakers
      t.string :script
      t.text :description

      t.timestamps
    end
  end
end
