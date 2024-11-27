class CreateEquipmentCategoriesService
  FILE_PATH = './lib/json/Equipment-Categories.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    @data.each do |equipment_category|
      EquipmentCategory.find_or_create_by!(
        name: equipment_category['name']
      )
    end
  end
end
