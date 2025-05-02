class CreateLanguagesService
  FILE_PATH = './lib/json/Languages.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Languages...'
    @data.each do |language|
      Language.find_or_create_by!(
        name: language['name'],
        description: language['desc'],
        language_type: language['type'],
        script: language['script'],
        typical_speakers: language['typical_speakers'].join("\n")
      )
    end
  end
end
