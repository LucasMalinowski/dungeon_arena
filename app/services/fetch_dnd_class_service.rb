class FetchDndClassService
  BASE_URL = 'https://www.dnd5eapi.co/api/classes'

  def initialize(class_index)
    @class_index = class_index
  end

  def call
    response = Faraday.get("#{BASE_URL}/#{@class_index}")
    if response.success?
      JSON.parse(response.body)
    else
      raise "Failed to fetch class details for #{@class_index}: #{response.status} #{response.body}"
    end
  end
end
