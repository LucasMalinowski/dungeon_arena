class FetchAndSaveDndClassesService
  BASE_URL = 'https://www.dnd5eapi.co/api/classes'

  def call
    classes = fetch_classes
    classes.each do |class_info|
      process_class(class_info['index'])
    end
    puts "All classes have been fetched and saved."
  end

  private

  # Fetch the list of classes from the API
  def fetch_classes
    puts "Fetching list of classes..."
    response = Faraday.get(BASE_URL)
    if response.success?
      JSON.parse(response.body)['results']
    else
      raise "Failed to fetch classes: #{response.status} #{response.body}"
    end
  end

  # Fetch and save a specific class
  def process_class(class_index)
    puts "Processing class: #{class_index}"
    class_details = FetchDndClassService.new(class_index).call
    SaveDndClassService.new(class_details).call
    puts "Saved class: #{class_details['name']}"
  rescue StandardError => e
    puts "Failed to process class #{class_index}: #{e.message}"
  end
end
