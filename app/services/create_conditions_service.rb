class CreateConditionsService
  FILE_PATH = './lib/json/Conditions.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Conditions...'
    @data.each do |condition|
      Condition.find_or_create_by!(
        name: condition['name'],
        description: condition['desc'].join("\n")
      )
    end
  end
end
