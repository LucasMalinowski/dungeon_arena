class FixMonsters < ActiveRecord::Migration[7.1]
  def change
    drop_table :damage_proficiencies

    create_table :monster_proficiencies do |t|
      t.integer :value
      t.belongs_to :monster, index: true
      t.belongs_to :proficiency, index: true
    end
  end
end
