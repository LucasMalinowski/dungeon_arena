class CreateSubclassesService
  FILE_PATH = './lib/json/Subclasses.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Subclasses...'
    @data.each do |subclass_data|
      sub_class = Subclass.find_or_create_by!(name: subclass_data['name'])
      sub_class.description = subclass_data['desc'].join("\n")
      sub_class.subclass_flavor = subclass_data['subclass_flavor']
      sub_class.klass = Klass.find_or_create_by!(name: subclass_data['class']['name'])

      subclass_data['spells'].each do |spell|
        sub_class.spell_subclasses << SpellSubclass.find_or_create_by!(spell: Spell.find_by(name:spell['spell']['name']), subclass: sub_class)

        spell['prerequisites'].each do |prerequisite|
          new_prerequisite = SubclassSpellPrerequisite.create(subclass: sub_class,
                                                              spell: Spell.find_by(name: spell['spell']['name']),
                                                              prerequisite_type: prerequisite['type'],
                                                              name: prerequisite['name']
          )
          sub_class.subclass_spell_prerequisites << new_prerequisite
        end
      end if subclass_data['spells']
    end
  end
end
