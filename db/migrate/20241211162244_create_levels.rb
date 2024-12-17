class CreateLevels < ActiveRecord::Migration[7.1]
  def change
    create_table :levels do |t|
      t.integer :level
      t.integer :ability_score_bonus
      t.integer :proficiency_bonus
      t.references :klass, null: false, foreign_key: true
      t.references :subclass, foreign_key: true

      t.timestamps
    end

    create_table :level_specifics do |t|
      t.string :name
      t.jsonb :data
      t.references :level, null: false, foreign_key: true
    end

    create_table :level_features do |t|
      t.references :level, null: false, foreign_key: true
      t.references :feature, null: false, foreign_key: true
    end

    create_table :level_spellcastings do |t|
      t.references :level, null: false, foreign_key: true
      t.integer :spell_slots_level_1
      t.integer :spell_slots_level_2
      t.integer :spell_slots_level_3
      t.integer :spell_slots_level_4
      t.integer :spell_slots_level_5
      t.integer :spell_slots_level_6
      t.integer :spell_slots_level_7
      t.integer :spell_slots_level_8
      t.integer :spell_slots_level_9
      t.integer :spells_known
      t.integer :cantrips_known
    end
  end
end
