class CreateSubraceProficiency < ActiveRecord::Migration[7.1]
  def change
    create_table :subrace_proficiencies do |t|
      t.references :subrace, foreign_key: true
      t.references :proficiency, foreign_key: true

      t.timestamps
    end
  end
end
