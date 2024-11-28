class CreateEquipmentsService
  FILE_PATH = './lib/json/Equipment.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Equipments...'
    @data.each do |equipment|
      case equipment['equipment_category']['index']
      when 'weapon'
        create_weapon(equipment)
      when 'armor'
        create_armor(equipment)
      when 'adventuring-gear'
        create_adventuring_gear(equipment)
      when 'tools'
        create_tool(equipment)
      when 'mounts-and-vehicles'
        create_mount(equipment)
      end
    end
  end

  private

  def create_weapon(equipment)
    created_item = Weapon.find_or_create_by!(name: equipment['name'].presence) do |item|
      item.weapon_category = equipment['weapon_category'].presence
      item.weapon_range = equipment['weapon_range'].presence
      item.category_range = equipment['category_range'].presence
      item.normal_range = equipment['range']['normal'].presence
      item.long_range = equipment['range']['long'].presence
      item.weight = equipment['weight'].presence
      item.special = equipment['special'].presence&.join("\n")

      if equipment['cost']
        item.cost_quantity = equipment['cost']['quantity']
        item.cost_unity = equipment['cost']['unit']
      end

      if equipment['throw_range']
        item.throw_range_normal = equipment['throw_range']['normal']
        item.throw_range_long = equipment['throw_range']['long']
      end

      item.equipment_category = EquipmentCategory.find_by(name: equipment['equipment_category']['name'])

      item.weapon_properties_weapons = equipment['properties'].map do |property|
        WeaponPropertyWeapons.find_or_create_by!(weapon_property: WeaponProperty.find_by(name: property['name']), weapon: item)
      end

      if equipment['damage']
        item.damage_dice = equipment['damage']['damage_dice']
        item.weapon_damage_types << WeaponDamageTypes.find_or_create_by!(weapon: item,
                                              damage_type: DamageType.find_by(name: equipment['damage']['damage_type']['name']),
                                              damage_instance: "One Handed"
        )
      end

      if equipment['two_handed_damage']
        item.two_hand_damage_dice = equipment['two_handed_damage']['damage_dice']
        item.weapon_damage_types << WeaponDamageTypes.find_or_create_by!(weapon: item,
                                              damage_type: DamageType.find_by(name: equipment['two_handed_damage']['damage_type']['name']),
                                              damage_instance: "Two Handed"
        )
      end
    end

    Equipment.create!(equipmentable: created_item, name: created_item.name)
  end

  def create_armor(equipment)
    created_item = Armor.find_or_create_by!(name: equipment['name'].presence) do |item|
      item.armor_class = equipment['armor_class']['base'].presence
      item.armor_class_bonus = equipment['armor_class']['dex_bonus'].presence
      item.armor_category = equipment['armor_category'].presence
      item.weight = equipment['weight'].presence
      item.stealth_disadvantage = equipment['stealth_disadvantage'].presence
      item.strength_requirement = equipment['str_minimum'].presence

      if equipment['cost']
        item.cost_quantity = equipment['cost']['quantity']
        item.cost_unity = equipment['cost']['unit']
      end

      item.equipment_category = EquipmentCategory.find_by(name: equipment['equipment_category']['name'])
    end

    Equipment.create!(equipmentable: created_item, name: created_item.name)
  end

  def create_adventuring_gear(equipment)
    created_item = AdventuringGear.find_or_create_by!(name: equipment['name'].presence) do |item|
      item.weight = equipment['weight'].presence
      item.gear_category = equipment['gear_category']['name'].presence
      item.description = equipment['desc'] ? equipment['desc'].join("\n") : ""

      if equipment['cost']
        item.cost_quantity = equipment['cost']['quantity']
        item.cost_unity = equipment['cost']['unit']
      end

      item.equipment_category = EquipmentCategory.find_by(name: equipment['equipment_category']['name'])
    end

    Equipment.create!(equipmentable: created_item, name: created_item.name)
  end

  def create_tool(equipment)
    created_item = Tool.find_or_create_by!(name: equipment['name'].presence) do |item|
      item.weight = equipment['weight'].presence
      item.tool_category = equipment['tool_category'].presence
      item.description = equipment['desc'] ? equipment['desc'].join("\n") : ""

      if equipment['cost']
        item.cost_quantity = equipment['cost']['quantity']
        item.cost_unity = equipment['cost']['unit']
      end

      item.equipment_category = EquipmentCategory.find_by(name: equipment['equipment_category']['name'])
    end

    Equipment.create!(equipmentable: created_item, name: created_item.name)
  end

  def create_mount(equipment)
    created_item = Mount.find_or_create_by!(name: equipment['name'].presence) do |item|
      item.weight = equipment['weight'].presence
      item.carry_capacity = equipment['capacity'].presence
      item.description = equipment['desc'] ? equipment['desc'].join("\n") : ""

      if item['speed']
        item.speed = equipment['speed']['quantity']
        item.speed_unity = equipment['speed']['unit']
      end

      if equipment['cost']
        item.cost_quantity = equipment['cost']['quantity']
        item.cost_unity = equipment['cost']['unit']
      end

      item.equipment_category = EquipmentCategory.find_by(name: equipment['equipment_category']['name'])
    end

    Equipment.create!(equipmentable: created_item, name: created_item.name)
  end
end
