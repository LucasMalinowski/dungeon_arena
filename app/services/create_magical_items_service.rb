class CreateMagicalItemsService
  FILE_PATH = './lib/json/Magic-Items.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Magical Items...'
    @data.each do |magic_item|
      magical_item = MagicalItem.find_or_create_by!(name: magic_item['name'].presence) do |item|
        item.description = magic_item['desc'].join("\n") || ""
        item.rarity = magic_item['rarity'].presence
        item.cost_quantity = magic_item['cost']&['quantity']
        item.cost_unity = magic_item['cost']&['unit']
        item.weight = magic_item['weight'].presence
        item.variant = magic_item['variant'].presence
        item.variants = magic_item['variants'].presence
        item.equipment_category = EquipmentCategory.find_by(name: magic_item['equipment_category']['name'])
      end

      Equipment.create!(equipmentable: magical_item)
    end
  end
end
