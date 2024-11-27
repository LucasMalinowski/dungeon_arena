class CreateDndInformationsService
  CURRENT_PATH = File.dirname(__FILE__)
  def initialize; end

  def call
    p 'Creating D&D information...'
    ActiveRecord::Base.transaction do
      p Dir["#{CURRENT_PATH}/*.rb"]
      Dir["#{CURRENT_PATH}/*.rb"].each do |file_path|
        next if file_path == __FILE__
        require file_path

        puts "Creating #{File.basename(file_path, ".*")}..."
        puts "\n"
        file_path.camelize.split('.').first.split("::").last.constantize.new.call
      end
    end
  end
end