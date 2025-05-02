class CreateLevelsService
  FILE_PATH = './lib/json/Levels.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Levels...'
    @data.each_with_index do |level_data,index|
      klass = Klass.find_by(name: level_data['class']['name'])
      level = Level.find_or_create_by!(level: level_data['level'], klass: klass)

      level.update(ability_score_bonus: level_data['ability_score_bonuses'],
                   proficiency_bonus: level_data['prof_bonus'])

      handle_features(level, level_data['features'])
      handle_level_specifics(level, level_data['class_specific'])
      handle_spellcasting(level, level_data['spellcasting'])
    end
  end

  private

  def handle_features(level, features)
    features.each do |feature_data|
      feature = Feature.find_by(name: feature_data['name'])
      LevelFeature.find_or_create_by!(level: level, feature: feature)
    end
  end

  def handle_level_specifics(level, class_specific)
    return if class_specific.nil?
    class_specific.each do |key, value|
      LevelSpecific.find_or_create_by!(level: level,
                                       name: key,
                                       data: value)
    end
  end

  def handle_spellcasting(level, spellcasting_data)
    return if spellcasting_data.nil?

    LevelSpellcasting.find_or_create_by!(level: level,
                                         spell_slots_level_1: spellcasting_data['spell_slots_level_1'],
                                         spell_slots_level_2: spellcasting_data['spell_slots_level_2'],
                                         spell_slots_level_3: spellcasting_data['spell_slots_level_3'],
                                         spell_slots_level_4: spellcasting_data['spell_slots_level_4'],
                                         spell_slots_level_5: spellcasting_data['spell_slots_level_5'],
                                         spell_slots_level_6: spellcasting_data['spell_slots_level_6'],
                                         spell_slots_level_7: spellcasting_data['spell_slots_level_7'],
                                         spell_slots_level_8: spellcasting_data['spell_slots_level_8'],
                                         spell_slots_level_9: spellcasting_data['spell_slots_level_9'],
                                         spells_known: spellcasting_data['spells_known'],
                                         cantrips_known: spellcasting_data['cantrips_known'])
  end
end
