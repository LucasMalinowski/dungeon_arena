class CreateRulesService
  FILE_PATH = './lib/json/Rule-Sections.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Rules...'
    @data.each do |rule|
      Rule.find_or_create_by!(name: rule['name']) do |r|
        r.description = rule['desc']
      end
    end
  end
end
