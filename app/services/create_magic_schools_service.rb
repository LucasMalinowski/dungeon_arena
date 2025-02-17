class CreateMagicSchoolsService
  FILE_PATH = './lib/json/Magic-Schools.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Magic Schools...'
    @data.each do |magic_school|
      MagicSchool.find_or_create_by!(
        name: magic_school['name'],
        description: magic_school['desc']
      )
    end
  end
end
