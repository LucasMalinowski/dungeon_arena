class CreateCharacter < ActiveRecord::Migration[7.1]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :klass

      # physical attributes
      t.string :skin_color
      t.string :hair_color
      t.string :eye_color
      t.string :gender
      t.float :height
      t.float :weight
      t.integer :age

      # notes
      t.text :notes
      t.text :backstory
      t.string :alignment
      t.string :allies
      t.string :enemies
      t.string :faith
      t.string :lifestyle

      # personality traits
      t.string :personality
      t.string :ideals
      t.string :bonds
      t.string :flaws

      # species
      t.string :species

      # ability scores
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma

      t.timestamps
    end
  end
end
