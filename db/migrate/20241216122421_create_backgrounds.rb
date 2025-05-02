class CreateBackgrounds < ActiveRecord::Migration[7.1]
  def change
    create_table :backgrounds do |t|
      t.string :name
      t.string :feature_name
      t.text :feature_description
      t.text :description
      t.text :starting_equipment
      t.text :tool_proficiencies
      t.text :language_options

      t.timestamps
    end

    create_table :background_proficiencies do |t|
      t.references :background, null: false, foreign_key: true
      t.references :proficiency, null: false, foreign_key: true
    end

    create_table :background_personality_trait_choices do |t|
      t.references :background, null: false, foreign_key: true
      t.integer :choose
    end

    create_table :background_personality_trait_choice_options do |t|
      t.references :background_personality_trait_choice, null: false, foreign_key: true
      t.text :description
    end

    create_table :background_ideal_choices do |t|
      t.references :background, null: false, foreign_key: true
      t.integer :choose
    end

    create_table :background_ideal_choice_options do |t|
      t.references :background_ideal_choice, null: false, foreign_key: true
      t.text :description
    end

    create_table :background_ideal_option_alignments do |t|
      t.references :background_ideal_choice_option, null: false, foreign_key: true
      t.references :alignment, null: false, foreign_key: true
    end

    create_table :background_bond_choices do |t|
      t.references :background, null: false, foreign_key: true
      t.integer :choose
    end

    create_table :background_bond_choice_options do |t|
      t.references :background_bond_choice, null: false, foreign_key: true
      t.text :description
    end

    create_table :background_flaw_choices do |t|
      t.references :background, null: false, foreign_key: true
      t.integer :choose
    end

    create_table :background_flaw_choice_options do |t|
      t.references :background_flaw_choice, null: false, foreign_key: true
      t.text :description
    end
  end
end
