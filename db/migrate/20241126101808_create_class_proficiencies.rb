class CreateClassProficiencies < ActiveRecord::Migration[7.1]
  def change
    create_table :class_proficiencies do |t|
      t.references :klass, null: false, foreign_key: { to_table: :klasses }
      t.references :proficiency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
