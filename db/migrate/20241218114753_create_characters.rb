class CreateCharacters < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :exp

      t.references :user, null: false, foreign_key: true
      t.references :background, foreign_key: true
      t.references :alignment, foreign_key: true
      t.references :race, foreign_key: true
      t.references :subrace, foreign_key: true

      t.timestamps
    end

    create_table :character_classes do |t|
      t.references :character, null: false, foreign_key: true
      t.references :klass, null: false, foreign_key: true
      t.integer :level, default: 1
      t.timestamps
    end

    create_table :character_ability_scores do |t|
      t.references :character, null: false, foreign_key: true
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma
      t.timestamps
    end

    create_table :character_skills do |t|
      t.references :character, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true
      t.integer :proficiency
      t.timestamps
    end

    create_table :character_inventories do |t|
      t.references :character, null: false, foreign_key: true
      t.integer :copper
      t.integer :silver
      t.integer :electrum
      t.integer :gold
      t.integer :platinum
      t.timestamps
    end

    create_table :inventory_items do |t|
      t.references :character_inventory, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.integer :quantity
    end

    create_table :character_physical_characteristics do |t|
      t.references :character, null: false, foreign_key: true
      t.string :gender
      t.integer :age
      t.string :height
      t.string :weight
      t.string :eye_color
      t.string :hair_color
      t.string :skin_color
      t.text :distinguishing_features
      t.timestamps
    end

    create_table :character_notes do |t|
      t.references :character, null: false, foreign_key: true
      t.string :allies
      t.string :organizations
      t.string :enemies
      t.string :faith
      t.string :lifestyle
      t.text :notes
      t.text :backstory
      t.text :other
      t.timestamps
    end
  end
end
