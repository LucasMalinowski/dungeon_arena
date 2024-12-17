class UpdateRaces < ActiveRecord::Migration[7.1]
  def change
    add_column :races, :speed, :integer
    add_column :races, :alignment_description, :text
    add_column :races,:age_description, :text
    add_column :races, :size, :string
    add_column :races,:size_description, :text
    add_column :races, :language_description, :text

    create_table :race_ability_bonus do |t|
      t.references :race
      t.references :ability_score
      t.integer :bonus
    end

    create_table :race_ability_bonus_choices do |t|
      t.references :race
      t.integer :choose
    end

    create_table :race_ability_bonus_choice_options do |t|
      t.references :race_ability_bonus_choice
      t.references :ability_score
    end

    create_table :race_proficiency_choices do |t|
      t.references :race
      t.string :description
      t.integer :choose
    end

    create_table :race_proficiency_choice_options do |t|
      t.references :race_proficiency_choice
      t.references :proficiency
    end

    create_table :race_languages do |t|
      t.references :race
      t.references :language
    end

    create_table :race_language_choices do |t|
      t.references :race
      t.integer :choose
    end

    create_table :race_language_choice_options do |t|
      t.references :race_language_choice
      t.references :language
    end
  end
end
