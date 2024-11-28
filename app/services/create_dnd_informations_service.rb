class CreateDndInformationsService
  CURRENT_PATH = File.dirname(__FILE__)
  def initialize; end

  def call
    p 'Creating D&D information...'
    ActiveRecord::Base.transaction do
      CreateAbilityScoresService.new.call
      CreateAlignmentsService.new.call
      CreateConditionsService.new.call
      CreateDamageTypesService.new.call
      CreateEquipmentCategoriesService.new.call
      CreateLanguagesService.new.call
      CreateMagicSchoolsService.new.call
      CreateSkillsService.new.call
      CreateWeaponPropertiesService.new.call
      CreateEquipmentsService.new.call
      CreateMagicalItemsService.new.call
    end
  end
end