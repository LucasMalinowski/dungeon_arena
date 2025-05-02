class CreateSubclassSpellsPrerequisites < ActiveRecord::Migration[7.1]
  def change
    create_table :subclass_spell_prerequisites do |t|
      t.string :prerequisite_type
      t.string :name

      t.references :subclass, null: false, foreign_key: true
      t.references :spell, null: false, foreign_key: true

      t.timestamps
    end
  end
end
