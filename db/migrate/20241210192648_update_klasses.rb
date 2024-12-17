class UpdateKlasses < ActiveRecord::Migration[7.1]
  def change
    add_column :klasses, :hit_die, :integer
    add_reference :equipment, :equipment_category, foreign_key: true

    create_table :proficiency_choices do |t|
      t.references :klass, null: false, foreign_key: true
      t.string :description
      t.integer :choose
      t.string :proficiency_type
    end

    create_table :proficiency_choice_options do |t|
      t.references :proficiency_choice, null: false, foreign_key: true
      t.references :proficiency, null: false, foreign_key: true
    end

    create_table :multiclassings do |t|
      t.references :klass, null: false, foreign_key: true
    end

    create_table :multiclassing_prerequisites do |t|
      t.references :multiclassing, null: false, foreign_key: true
      t.references :ability_score, null: false, foreign_key: true
      t.integer :minimum_score
    end

    create_table :multiclassing_proficiencies do |t|
      t.references :multiclassing, null: false, foreign_key: true
      t.references :proficiency, null: false, foreign_key: true
    end

    create_table :multiclassing_proficiency_choices do |t|
      t.references :multiclassing, null: false, foreign_key: true
      t.references :proficiency_choice, null: false, foreign_key: true
    end

    create_table :saving_throws do |t|
      t.references :ability_score, null: false, foreign_key: true
    end

    create_table :class_saving_throws do |t|
      t.references :klass, null: false, foreign_key: true
      t.references :saving_throw, null: false, foreign_key: true
    end

    create_table :class_starting_equipments do |t|
      t.integer :quantity

      t.references :klass, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.references :equipment_category, null: false, foreign_key: true
    end

    create_table :class_starting_equipment_choices do |t|
      t.integer :choose
      t.string :choice_type
      t.string :description
      t.references :klass, null: false, foreign_key: true
    end

    create_table :class_starting_equipment_choice_options do |t|
      t.integer :quantity
      t.references :class_starting_equipment_choice, null: false, foreign_key: true
      t.references :equipment, foreign_key: true
      t.references :equipment_category, foreign_key: true
    end

    create_table :class_spellcastings do |t|
      t.integer :level, null: false
      t.references :ability_score, null: false, foreign_key: true
      t.references :klass, null: false, foreign_key: true
    end

    create_table :spellcasting_infos do |t|
      t.references :class_spellcasting, null: false, foreign_key: true
      t.string :name, null: false
      t.jsonb :description, default: []

      t.timestamps
    end
  end
end
