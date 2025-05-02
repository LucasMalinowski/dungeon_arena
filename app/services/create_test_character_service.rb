class CreateTestCharacterService
  def initialize; end

  def call
    p 'Creating test character...'
    ActiveRecord::Base.transaction do
      klass = Klass.find_by(name: "Barbarian")
      race = Race.find_by(name: "Dwarf")
      character = Character.create!(name: "Test Character", user: User.first)
      CharacterClass.create!(character: character, klass: klass, level: 1)

      create_character_ability_scores(character)
      create_character_skills(character)
      create_character_inventory(character)
      create_character_physical_characteristic(character)
      create_character_notes(character)
    end
  end

  private

  def create_character_ability_scores(character)
    CharacterAbilityScore.create!(
      character: character,
      strength: 10,
      dexterity: 10,
      constitution: 10,
      intelligence: 10,
      wisdom: 10,
      charisma: 10
    )
  end

  def create_character_skills(character)
    Skill.all.each do |skill|
      CharacterSkill.create!(
        character: character,
        skill: skill,
        proficiency: 0
      )
    end
  end

  def create_character_inventory(character)
    inventory = CharacterInventory.create!(
      character: character,
      copper: 0,
      silver: 0,
      electrum: 0,
      gold: 0,
      platinum: 0
    )

    character.starting_equipments.each do |equipment|
      InventoryItem.create!(
        character_inventory: inventory,
        equipment: equipment.equipment,
        quantity: equipment.quantity
      )
    end
  end

  def create_character_physical_characteristic(character)
    CharacterPhysicalCharacteristic.create!(
      character: character,
      gender: "Male",
      eye_color: "Brown",
      hair_color: "Black",
      skin_color: "White",
      age: 20,
      height: "1,78",
      weight: 80,
    )
  end

  def create_character_notes(character)
    CharacterNote.create!(
      character: character,
      notes: "This is a test character"
    )
  end
end


