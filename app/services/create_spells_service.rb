class CreateSpellsService
  FILE_PATH = './lib/json/Spells.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Spells...'
    @data.each do |spell|
      Spell.find_or_create_by!(name: spell['name']) do |sp|
        sp.description = spell['desc'].join("\n")
        sp.range = spell['range']
        sp.components = spell['components'].join(', ')
        sp.material = spell['material']
        sp.ritual = spell['ritual']
        sp.duration = spell['duration']
        sp.concentration = spell['concentration']
        sp.casting_time = spell['casting_time']
        sp.level = spell['level']
        sp.higher_level = spell['higher_level']
        sp.attack_type = spell['attack_type']
        sp.cantrip = spell['level'] == 0

        sp.magic_school = MagicSchool.find_by(name: spell['school']['name'])

        spell['classes'].each do |klass|
          sp.spell_classes << SpellClass.find_or_create_by!(spell: sp, klass: Klass.find_or_create_by!(name: klass['name']))
        end

        spell['subclasses'].each do |subclass|
          sp.spell_subclasses << SpellSubclass.find_or_create_by!(spell: sp, subclass: Subclass.find_by(name: subclass['name']))
        end

        if spell['damage']
          sp.damage_at_slot_level = spell['damage']['damage_at_slot_level']
          sp.damage_at_character_level = spell['damage']['damage_at_character_level']
          sp.damage_type = DamageType.find_by(name: spell['damage']['damage_type']['name']) if spell['damage']['damage_type']
        end

        if spell['heal_at_slot_level']
          sp.heal_at_slot_level = spell['heal_at_slot_level']
        end

        if spell['area_of_effect']
          sp.area_of_effect_type = spell['area_of_effect']['type']
          sp.area_of_effect_size = spell['area_of_effect']['size']
        end

        if spell['dc']
          sp.dc_type = spell['dc']['dc_type']['name']
          sp.dc_success = spell['dc']['dc_success']
        end
      end
    end
  end
end

a = Spell.all.sample