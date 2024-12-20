class CreateFeatsService
  FILE_PATH = './lib/json/Feats.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Feats...'
    @data.each do |feat_data|
      Feat.find_or_create_by!(name: feat_data['name']) do |feat|
        feat.description = feat_data['desc'].join("\n")
        if feat_data['prerequisites'].present?
          feat.ability_score = AbilityScore.find_by(name: feat_data['prerequisites'].first['ability_score']['name'])
          feat.minimum_score = feat_data['prerequisites'].first['minimum_score']
        end
      end
    end
  end
end
