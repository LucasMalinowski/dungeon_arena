class CreateWeaponPropertiesService
  FILE_PATH = './lib/json/Weapon-Properties.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Weapon Properties...'
    @data.each do |weapon_property|
      WeaponProperty.find_or_create_by!(
        name: weapon_property['name'],
        description: weapon_property['desc'].join("\n")
      )
    end
  end
end
