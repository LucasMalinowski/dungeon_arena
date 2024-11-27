class CreateSkillsService
  FILE_PATH = './lib/json/Skills.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    @data.each do |skill|
      Skill.find_or_create_by!(
        name: skill['name'],
        description: skill['desc'].join("\n"),
        ability_score: AbilityScore.find_by(name: skill['ability_score']['name'])
      )
    end
  end
end
