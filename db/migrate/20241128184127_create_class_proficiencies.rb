class CreateClassProficiencies < ActiveRecord::Migration[7.1]
  def change
    create_table :class_proficiencies do |t|
      t.references :klass, foreign_key: true
      t.references :proficiency, foreign_key: true

      t.timestamps
    end
  end
end
