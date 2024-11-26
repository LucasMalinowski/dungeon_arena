class SaveDndClassService
  def initialize(class_data)
    @class_data = class_data
  end

  def call
    ActiveRecord::Base.transaction do
      klass = Klass.find_or_create_by!(
        index: @class_data['index'],
        name: @class_data['name'],
        hit_die: @class_data['hit_die'],
        url: @class_data['url']
      )

      save_proficiencies(klass)
      save_saving_throws(klass)
      save_starting_equipment(klass)
    end
  end

  private

  def save_proficiencies(klass)
    @class_data['proficiencies'].each do |prof|
      proficiency = Proficiency.find_or_create_by!(
        index: prof['index'],
        name: prof['name'],
        url: prof['url']
      )
      klass.proficiencies << proficiency unless klass.proficiencies.include?(proficiency)
    end
  end

  def save_saving_throws(klass)
    @class_data['saving_throws'].each do |saving_throw|
      throw = SavingThrow.find_or_create_by!(
        index: saving_throw['index'],
        name: saving_throw['name'],
        url: saving_throw['url']
      )
      klass.saving_throws << throw unless klass.saving_throws.include?(throw)
    end
  end

  def save_starting_equipment(klass)
    @class_data['starting_equipment'].each do |equipment|
      item = Equipment.find_or_create_by!(
        index: equipment['equipment']['index'],
        name: equipment['equipment']['name'],
        url: equipment['equipment']['url']
      )
      klass.class_starting_equipment.find_or_create_by!(
        equipment: item,
        quantity: equipment['quantity']
      )
    end
  end
end
