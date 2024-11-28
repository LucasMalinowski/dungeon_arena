class CreateAbilityScoresService
  FILE_PATH = './lib/json/Ability-Scores.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Ability Scores...'
    @data.each do |ability_score|
      AbilityScore.find_or_create_by!(
        name: ability_score['name'],
        full_name: ability_score['full_name'],
        desc: ability_score['desc'].join("\n"),
      )
    end
  end
end
