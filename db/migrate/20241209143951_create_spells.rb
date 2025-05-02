class CreateSpells < ActiveRecord::Migration[7.1]
  def change
    create_table :spells do |t|
      t.string :name
      t.string :description
      t.string :range
      t.string :components
      t.string :material
      t.boolean :ritual
      t.string :duration
      t.boolean :concentration
      t.string :casting_time
      t.string :level
      t.string :higher_level
      t.string :attack_type
      t.jsonb :damage_at_slot_level
      t.jsonb :damage_at_character_level
      t.jsonb :heal_at_slot_level
      t.string :area_of_effect_type
      t.string :area_of_effect_size
      t.string :dc_type
      t.string :dc_success
      t.references :magic_school, foreign_key: true
      t.references :damage_type, foreign_key: true

      t.timestamps
    end

    create_table :spell_classes do |t|
      t.references :spell, foreign_key: true
      t.references :klass, foreign_key: true
    end

    create_table :spell_subclasses do |t|
      t.references :spell, foreign_key: true
      t.references :subclass, foreign_key: true
    end
  end
end
