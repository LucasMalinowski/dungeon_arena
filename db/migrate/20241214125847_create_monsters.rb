class CreateMonsters < ActiveRecord::Migration[7.1]
  def change
    # This is the migration for the monsters table
    create_table :monsters do |t|
      t.string :name
      t.string :description
      t.string :monster_subtype
      t.string :size
      t.string :monster_type
      t.string :alignment
      t.integer :hit_points
      t.string :hit_dice
      t.string :hit_points_roll
      t.jsonb :speed
      t.jsonb :armor_class, null: false, default: []

      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma

      t.jsonb :senses
      t.string :languages
      t.integer :challenge_rating
      t.integer :proficiency_bonus
      t.integer :exp

      t.timestamps
    end

    create_table :damage_proficiencies do |t|
      t.integer :value
      t.belongs_to :monster, index: true
      t.belongs_to :proficiency, index: true
    end

    create_table :monster_special_abilities do |t|
      t.references :monster, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.jsonb :dc, default: {}, null: true
      t.jsonb :spellcasting, default: {}, null: true
      t.jsonb :usage, default: {}, null: true

      t.timestamps
    end

    create_table :monster_actions do |t|
      t.references :monster, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.string :multiattack_type
      t.jsonb :sub_actions, default: [], null: true
      t.integer :attack_bonus
      t.jsonb :damage, default: [], null: true
      t.jsonb :dc, default: {}, null: true
      t.jsonb :usage, default: {}, null: true
      t.jsonb :options, default: {}, null: true

      t.timestamps
    end

    create_table :monster_legendary_actions do |t|
      t.references :monster, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.integer :attack_bonus
      t.jsonb :damage, default: [], null: true
      t.jsonb :dc, default: {}, null: true

      t.timestamps
    end

    create_table :monster_reactions do |t|
      t.references :monster, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.jsonb :dc, default: {}, null: true

      t.timestamps
    end

    create_table :monster_damage_vulnerabilities do |t|
      t.string :damage_type_name
      t.references :monster, null: false, foreign_key: true
      t.references :damage_type, null: true, foreign_key: true
    end

    create_table :monster_damage_resistances do |t|
      t.string :damage_type_name
      t.references :monster, null: false, foreign_key: true
      t.references :damage_type, null: true, foreign_key: true
    end

    create_table :monster_damage_immunities do |t|
      t.string :damage_type_name
      t.references :monster, null: false, foreign_key: true
      t.references :damage_type, null: true, foreign_key: true
    end

    create_table :monster_condition_immunities do |t|
      t.string :condition_name
      t.references :monster, null: false, foreign_key: true
      t.references :condition, null: false, foreign_key: true
    end

    # This is for monster_json
    create_table :monster_jsons do |t|
      t.string :name
      t.jsonb :data
      t.timestamps
    end
  end
end
