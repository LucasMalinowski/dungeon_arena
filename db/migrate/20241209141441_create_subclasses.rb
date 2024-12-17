class CreateSubclasses < ActiveRecord::Migration[7.1]
  def change
    create_table :subclasses do |t|
      t.string :name
      t.text :description
      t.string :subclass_flavor
      t.references :klass, foreign_key: true

      t.timestamps
    end
  end
end
