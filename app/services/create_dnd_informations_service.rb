class CreateDndInformationsService
  CURRENT_PATH = File.dirname(__FILE__)
  def initialize; end

  def call
    p 'Creating D&D information...'
    ActiveRecord::Base.transaction do
      create_basic_classes
      create_basic_races

      CreateAbilityScoresService.new.call
      CreateAlignmentsService.new.call
      CreateConditionsService.new.call
      CreateDamageTypesService.new.call
      CreateEquipmentCategoriesService.new.call
      CreateLanguagesService.new.call
      CreateMagicSchoolsService.new.call
      CreateSkillsService.new.call
      CreateWeaponPropertiesService.new.call
      CreateProficienciesService.new.call
      CreateFeatsService.new.call
      CreateRulesService.new.call
      CreateRuleScopesService.new.call
      CreateSkillsService.new.call
      CreateSpellsService.new.call
      CreateSubclassesService.new.call
      CreateFeaturesService.new.call
      CreateEquipmentsService.new.call
      CreateMagicalItemsService.new.call
      CreateClassesService.new.call
      CreateLevelsService.new.call
      CreateBackgroundsService.new.call
      CreateMonstersService.new.call
      CreateRacesService.new.call
      CreateSubracesService.new.call
      CreateTraitsService.new.call
    end
  end

  private

  def create_basic_classes
    p "Creating basic info"
    classes = %w[Barbarian Bard Cleric Druid Fighter Monk Paladin Ranger Rogue Sorcerer Warlock Wizard]
    sub_classes = {
      'Barbarian' => "Berserker",
      'Bard' => "Lore",
      'Cleric' => "Life",
      'Druid' => "Land",
      'Fighter' => "Champion",
      'Monk' => "Open Hand",
      'Paladin' => "Devotion",
      'Ranger' => "Hunter",
      'Rogue' => "Thief",
      'Sorcerer' => "Draconic",
      'Warlock' => "Fiend",
      'Wizard' => "Evocation"
    }

    classes_primary_abilities = {
      'Barbarian' => %w[Strength],
      'Bard' => %w[Charisma],
      'Cleric' => %w[Wisdom],
      'Druid' => %w[Wisdom],
      'Fighter' => %w[Strength Dexterity],
      'Monk' => %w[Dexterity Wisdom],
      'Paladin' => %w[Strength Charisma],
      'Ranger' => %w[Dexterity Wisdom],
      'Rogue' => %w[Dexterity],
      'Sorcerer' => %w[Charisma],
      'Warlock' => %w[Charisma],
      'Wizard' => %w[Intelligence]
    }

    classes.each do |klass|
      primary_abilities = classes_primary_abilities[klass]
      Klass.find_or_create_by!(name: klass, primary_ability: primary_abilities.join(", "))
    end

    sub_classes.each do |klass, sub_class|
      Subclass.find_or_create_by!(name: sub_class) do |sub_klass|
        sub_klass.klass = Klass.find_by(name: klass)
      end
    end
  end

  def create_basic_races
    races = %w[Dwarf Elf Halfling Human Dragonborn Gnome Half-Elf Half-Orc Tiefling]
    subraces = {
      'Dwarf' => "Hill Dwarf",
      'Elf' => "High Elf",
      'Halfling' => "Lightfoot Halfling",
      'Gnome' => "Rock Gnome",
    }

    races.each do |race|
      Race.find_or_create_by!(name: race)
    end

    subraces.each do |race, subrace|
      Subrace.find_or_create_by!(name: subrace) do |sub_race|
        sub_race.race = Race.find_by(name: race)
      end
    end
  end
end