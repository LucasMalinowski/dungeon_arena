class CreateAlignmentsService
  FILE_PATH = './lib/json/Alignments.json'.freeze

  def initialize
    @data = JSON.parse(File.read(FILE_PATH))
  end

  def call
    p 'Creating Alignments...'
    @data.each do |alignment|
      Alignment.find_or_create_by!(
        name: alignment['name'],
        abbreviation: alignment['full_name'],
        description: alignment['desc'],
      )
    end
  end
end
