class CreateMonstersService
  FILE_PATH = './lib/json/Monsters.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Monsters...'
    @data.each do |monster_data|
      monster = Monster.find_or_create_by!(name: monster_data['name'])

      monster.update!(
        description: monster_data['desc'],
        monster_subtype: monster_data['subtype'],
        size: monster_data['size'],
        monster_type: monster_data['type'],
        alignment: monster_data['alignment'],
        hit_points: monster_data['hit_points'],
        hit_dice: monster_data['hit_dice'],
        hit_points_roll: monster_data['hit_points_roll'],
        speed: monster_data['speed'],
        armor_class: normalize_armor_class(monster_data['armor_class']),
        strength: monster_data['strength'],
        dexterity: monster_data['dexterity'],
        constitution: monster_data['constitution'],
        intelligence: monster_data['intelligence'],
        wisdom: monster_data['wisdom'],
        charisma: monster_data['charisma'],
        senses: monster_data['senses'],
        languages: monster_data['languages'],
        challenge_rating: monster_data['challenge_rating'],
        proficiency_bonus: monster_data['proficiency_bonus'],
        exp: monster_data['xp']
      )

      handle_special_abilities(monster, monster_data)
      handle_actions(monster, monster_data)
      handle_legendary_actions(monster, monster_data)
      handle_reactions(monster, monster_data)
      handle_damage_vulnerabilities(monster, monster_data)
      handle_damage_resistances(monster, monster_data)
      handle_damage_immunities(monster, monster_data)
      handle_condition_immunities(monster, monster_data)

      monster.save!
    end
  end

  private

  def normalize_armor_class(armor_class_data)
    return [] unless armor_class_data.is_a?(Hash)

    armor_class_data.map do |type, details|
      { "type" => type, "value" => details["value"], "details" => details.except("value") }.compact
    end
  end

  def handle_special_abilities(monster, monster_data)
    return if monster_data['special_abilities'].nil?

    monster_data['special_abilities'].each do |ability_data|
      MonsterSpecialAbility.create!(
        monster: monster,
        name: ability_data['name'],
        description: ability_data['desc'],
        dc: ability_data['dc'],
        spellcasting: ability_data['spellcasting'],
        usage: ability_data['usage']
      )
    end
  end

  def handle_actions(monster, monster_data)
    return if monster_data['actions'].nil?

    monster_data['actions'].each do |action_data|
      MonsterAction.create!(
        monster: monster,
        name: action_data['name'],
        description: action_data['desc'],
        multiattack_type: action_data['multiattack_type'],
        sub_actions: action_data['actions'],
        attack_bonus: action_data['attack_bonus'],
        damage: action_data['damage'],
        dc: action_data['dc'],
        usage: action_data['usage'],
        options: action_data['options']
      )
    end
  end

  def handle_legendary_actions(monster, monster_data)
    return if monster_data['legendary_actions'].nil?

    monster_data['legendary_actions'].each do |legendary_action_data|
      MonsterLegendaryAction.create!(
        monster: monster,
        name: legendary_action_data['name'],
        description: legendary_action_data['desc'],
        attack_bonus: legendary_action_data['attack_bonus'],
        damage: legendary_action_data['damage'],
        dc: legendary_action_data['dc']
      )
    end
  end

  def handle_reactions(monster, monster_data)
    return if monster_data['reactions'].nil?

    monster_data['reactions'].each do |reaction_data|
      MonsterReaction.create!(
        monster: monster,
        name: reaction_data['name'],
        description: reaction_data['desc'],
        dc: reaction_data['dc']
      )
    end
  end

  def handle_damage_vulnerabilities(monster, monster_data)
    return if monster_data['damage_vulnerabilities'].nil?

    monster_data['damage_vulnerabilities'].each do |vulnerability|
      damage_type = DamageType.find_by(name: vulnerability.humanize)
      damage = vulnerability.humanize

      if damage_type.present?
        MonsterDamageVulnerability.create!(monster: monster, damage_type: damage_type)
      else
        MonsterDamageVulnerability.create!(monster: monster, damage_type_name: damage)
      end
    end
  end

  def handle_damage_resistances(monster, monster_data)
    return if monster_data['damage_resistances'].nil?

    monster_data['damage_resistances'].each do |resistance|
      damage_type = DamageType.find_by(name: resistance.humanize)
      damage = resistance.humanize

      if damage_type.present?
        MonsterDamageResistance.create!(monster: monster, damage_type: damage_type)
      else
        MonsterDamageResistance.create!(monster: monster, damage_type_name: damage)
      end
    end
  end

  def handle_damage_immunities(monster, monster_data)
    return if monster_data['damage_immunities'].nil?

    monster_data['damage_immunities'].each do |immunity|
      damage_type = DamageType.find_or_create_by!(name: immunity.humanize)
      damage = immunity.humanize

      if damage_type.present?
        MonsterDamageImmunity.create!(monster: monster, damage_type: damage_type)
      else
        MonsterDamageImmunity.create!(monster: monster, damage_type_name: damage)
      end
    end
  end

  def handle_condition_immunities(monster, monster_data)
    return if monster_data['condition_immunities'].nil?

    monster_data['condition_immunities'].each do |condition|
      condition_record = Condition.find_or_create_by!(name: condition['name'])
      MonsterConditionImmunity.create!(monster: monster, condition: condition_record)
    end
  end
end
