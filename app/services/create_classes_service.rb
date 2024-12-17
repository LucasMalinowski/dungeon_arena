class CreateClassesService
  FILE_PATH = './lib/json/Classes.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Classes...'
    @data.each do |class_data|
      klass = Klass.find_or_create_by!(name: class_data['name'])
      klass.update(hit_die: class_data['hit_die'])

      klass.proficiencies = class_data['proficiencies'].map do |proficiency|
        Proficiency.find_or_create_by!(name: proficiency['name'])
      end

      klass.save!

      handle_proficiency_choices(klass, class_data)
      handle_saving_throws(klass, class_data)
      handle_starting_equipment(klass, class_data)
      handle_starting_equipment_choices(klass, class_data)
      handle_spellcasting(klass, class_data)
      handle_multiclassing(klass, class_data)
    end
  end
  
  private
  
  def handle_proficiency_choices(klass, class_data)
    class_data['proficiency_choices'].each do |proficiency_choice_data|
      proficiency_choice = ProficiencyChoice.create!(
        choose: proficiency_choice_data['choose'],
        description: proficiency_choice_data['desc'],
        klass: klass,
        proficiency_type: proficiency_choice_data['type']
      )

      proficiency_choice_data['from']['options'].each do |proficiency_data|
        proficiency = Proficiency.find_or_create_by!(name: proficiency_data['item']['name'])
        ProficiencyChoiceOption.create!(
          proficiency_choice: proficiency_choice,
          proficiency: proficiency
        )
      end
    end

    klass.save!
  end

  def handle_saving_throws(klass, class_data)
    class_data['saving_throws'].each do |saving_throw_data|
      ability_score = AbilityScore.find_by(name: saving_throw_data['name'])
      saving_throw = SavingThrow.find_or_create_by!(
        ability_score: ability_score
      )

      ClassSavingThrow.create!(
        klass: klass,
        saving_throw: saving_throw
      )
    end

    klass.save!
  end

  def handle_starting_equipment(klass, class_data)
    class_data['starting_equipment'].each do |starting_equipment_data|
      equipment = Equipment.find_by(name: starting_equipment_data['equipment']['name'])

      ClassStartingEquipment.create!(
        quantity: starting_equipment_data['quantity'],
        klass: klass,
        equipment: equipment,
        equipment_category: equipment.equipment_category
      )
    end

    klass.save!
  end

  def handle_starting_equipment_choices(klass, class_data)
    class_data['starting_equipment_options'].each do |starting_equipment_choice_data|
      starting_equipment_choice = ClassStartingEquipmentChoice.create!(
        choose: starting_equipment_choice_data['choose'],
        description: starting_equipment_choice_data['desc'],
        klass: klass,
        choice_type: starting_equipment_choice_data['type']
      )
      if starting_equipment_choice_data['from']['option_set_type'] == 'options_array'
        starting_equipment_choice_data['from']['options'].each do |equipment_data|
          if equipment_data['option_type'] == 'choice'
            ClassStartingEquipmentChoiceOption.create!(
              class_starting_equipment_choice: starting_equipment_choice,
              quantity: equipment_data['quantity'],
              equipment_category: EquipmentCategory.find_by(name: equipment_data['choice']['from']['equipment_category']['name'])
            )
            next
          elsif equipment_data['option_type'] == 'multiple'
            equipment_data['items'].each do |item|
              if item['option_type'] == 'choice'
                equipment_category = EquipmentCategory.find_by(name: item['choice']['from']['equipment_category']['name'])
                ClassStartingEquipmentChoiceOption.create!(
                  class_starting_equipment_choice: starting_equipment_choice,
                  equipment_category: equipment_category,
                  quantity: item['quantity']
                )
                next
              else
                equipment = Equipment.find_by(name: item['of']['name'])
                ClassStartingEquipmentChoiceOption.create!(
                  class_starting_equipment_choice: starting_equipment_choice,
                  equipment: equipment,
                  quantity: item['quantity']
                )
              end
            end
            next
          else
            equipment = Equipment.find_by(name: equipment_data['of']['name'])
            ClassStartingEquipmentChoiceOption.create!(
              class_starting_equipment_choice: starting_equipment_choice,
              equipment: equipment,
              quantity: equipment_data['count']
            )
          end
        end
      else
        equipment_category = EquipmentCategory.find_by(name: starting_equipment_choice_data['from']['equipment_category']['name'])
        ClassStartingEquipmentChoiceOption.create!(
          class_starting_equipment_choice: starting_equipment_choice,
          equipment_category: equipment_category
        )
      end
    end

    klass.save!
  end

  def handle_spellcasting(klass, class_data)
    spellcasting_data = class_data['spellcasting']
    return unless spellcasting_data

    ability_score = AbilityScore.find_by(name: spellcasting_data['spellcasting_ability']['name'])
    class_spellcasting = ClassSpellcasting.create!(
      ability_score: ability_score,
      klass: klass,
      level: spellcasting_data['level']
    )

    spellcasting_data['info'].each do |spellcasting_info_data|
      SpellcastingInfo.create!(
        class_spellcasting: class_spellcasting,
        name: spellcasting_info_data['name'],
        description: spellcasting_info_data['desc'].join("\n")
      )
    end

    klass.save!
  end

  def handle_multiclassing(klass, class_data)
    multiclassing_data = class_data['multi_classing']
    multiclassing = Multiclassing.create!(
      klass: klass
    )

    multiclassing_data['prerequisites'].each do |prerequisite_data|
      ability_score = AbilityScore.find_by(name: prerequisite_data['ability_score']['name'])
      MulticlassingPrerequisite.create!(
        multiclassing: multiclassing,
        ability_score: ability_score,
        minimum_score: prerequisite_data['minimum_score']
      )
    end if multiclassing_data['prerequisites']

    multiclassing_data['proficiencies'].each do |proficiency_data|
      proficiency = Proficiency.find_by(name: proficiency_data['name'])
      MulticlassingProficiency.create!(
        multiclassing: multiclassing,
        proficiency: proficiency
      )
    end if multiclassing_data['proficiencies'].present?

    multiclassing_data['proficiency_choices'].each do |proficiency_choice_data|
      proficiency_choice = ProficiencyChoice.create(klass: klass,
                                                    proficiency_type: proficiency_choice_data['type'],
                                                    choose: proficiency_choice_data['choose'],
                                                    description: proficiency_choice_data['desc']
      )

      proficiency_choice_data['from']['options'].each do |proficiency_data|
        proficiency = Proficiency.find_by(name: proficiency_data['item']['name'])
        ProficiencyChoiceOption.create!(
          proficiency_choice: proficiency_choice,
          proficiency: proficiency
        )
      end
    end if multiclassing_data['proficiency_choices'].present?

    klass.save!
  end
end
