class CreateDamageTypesService
  FILE_PATH = './lib/json/Damage-Types.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Damage Types...'
    @data.each do |damage_type|
      DamageType.find_or_create_by!(
        name: damage_type['name'],
        description: damage_type['desc'].join("\n")
      )
    end
  end
end
