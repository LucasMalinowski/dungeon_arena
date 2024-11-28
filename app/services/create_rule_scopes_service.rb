class CreateRuleScopesService
  FILE_PATH = './lib/json/Rules.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Rule Scopes...'
    @data.each do |rule_scope|
      RuleScope.find_or_create_by!(name: rule_scope['name']) do |rs|
        rs.description = rule_scope['desc']
        rule_scope['subsections'].each do |sub|
          rs.rules << Rule.find_by(name: sub['name'])
        end
      end
    end
  end
end
