class CreateKlasses < ActiveRecord::Migration[7.1]
  def change
    create_table :klasses do |t|
      t.name :string

      t.timestamps
    end
  end
end
