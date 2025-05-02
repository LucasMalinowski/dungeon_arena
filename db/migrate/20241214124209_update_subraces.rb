class UpdateSubraces < ActiveRecord::Migration[7.1]
  def change
    add_column :subraces, :description, :text

    create_table :subrace_ability_bonus do |t|
      t.references :subrace
      t.references :ability_score
      t.integer :bonus
    end

    create_table :subrace_language_choices do |t|
      t.references :subrace
      t.integer :choose
    end

    create_table :subrace_language_choice_options do |t|
      t.references :subrace_language_choice
      t.references :language
    end
  end
end
