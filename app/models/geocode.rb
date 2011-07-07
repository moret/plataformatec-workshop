require "faraday"

class Geocode
  HOST = "http://maps.google.com"
  PATH = "/maps/api/geocode/json"
  URL = HOST + PATH

  def self.get(location)
    instance.get(location)
  end
  
  def self.instance
    @instance ||= new
  end

  # The above is the same as:
  # class << self
  #   delegate :get, :to => :instance
  # 
  #   private
  #
  #   def self.instance
  #     @instance ||= new
  #   end
  # end

  def get(location)
    response = get_response(location)
    json = parse_json(response.body)
    first = first_location(json)
    [first["lat"], first["lng"]]
  end

  private

  def get_response(location)
    Faraday.default_connection.get do |req|
      req.url Geocode::URL, :address => location, :sensor => false
    end
  end

  def parse_json(body)
    ActiveSupport::JSON.decode(body)
  end

  def first_location(json)
    json["results"].first["geometry"]["location"]
  end
end
