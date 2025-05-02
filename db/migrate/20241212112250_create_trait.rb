class CreateTrait < ActiveRecord::Migration[7.1]
  def change

    # This is the migration for the Trait model
    create_table :traits do |t|
      t.string :name
      t.text :description
      t.integer :parent_id

      t.timestamps
    end

    # Those are the migrations for the Trait model associations with race and subrace
    create_table :trait_races do |t|
      t.references :trait, null: false, foreign_key: true
      t.references :race, null: false, foreign_key: true
      t.timestamps
    end

    create_table :trait_subraces do |t|
      t.references :trait, null: false, foreign_key: true
      t.references :subrace, null: false, foreign_key: true

      t.timestamps
    end

    # Those are the migrations for the Trait model associations with proficiencies
    create_table :trait_proficiencies do |t|
      t.references :trait, null: false, foreign_key: true
      t.references :proficiency, null: false, foreign_key: true
    end

    create_table :trait_proficiency_choices do |t|
      t.references :trait, null: false, foreign_key: true
      t.integer :choose
    end

    create_table :trait_proficiency_choice_options do |t|
      t.references :trait_proficiency_choice, null: false, foreign_key: true
      t.references :proficiency, null: false, foreign_key: true
    end

    # Those are the migrations for the Trait model associations with languages
    create_table :trait_languages_choices do |t|
      t.references :trait, null: false, foreign_key: true
      t.integer :choose
    end

    create_table :trait_languages_choice_options do |t|
      t.references :trait_languages_choice, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true
    end

    # Those are the migrations for the Trait model associations with specific traits
    create_table :trait_specific_subtraits do |t|
      t.references :trait, null: false, foreign_key: true
      t.integer :choose

      t.timestamps
    end

    create_table :trait_specific_subtrait_options do |t|
      t.references :trait_specific_subtrait, null: false, foreign_key: true
      t.references :trait, null: false, foreign_key: true

      t.timestamps
    end

    # Those are the migrations for the Trait model associations with specific traits for spells
    create_table :trait_specific_spells do |t|
      t.references :trait, null: false, foreign_key: true
      t.integer :choose

      t.timestamps
    end

    create_table :trait_specific_spell_options do |t|
      t.references :trait_specific_spell, null: false, foreign_key: true
      t.references :spell, null: false, foreign_key: true

      t.timestamps
    end

    # Those are the migrations for the Trait model associations with specific traits for damage and breaths
    create_table :trait_specific_damage_breaths do |t|
      t.references :trait, null: false, foreign_key: true
      t.references :damage_type, null: false, foreign_key: true
      t.references :saving_throw, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :area_size
      t.string :area_type
      t.string :usage_type
      t.integer :usage_times
      t.string :dc_success_type
      t.jsonb :damage_at_character_level

      t.timestamps
    end

    # Fix minor things
    rename_column :ability_scores, :desc, :description
    rename_column :alignments, :desc, :description
    add_column :spells, :cantrip, :boolean, default: false
  end
end
