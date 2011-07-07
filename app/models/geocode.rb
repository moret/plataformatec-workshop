require "faraday"

class Geocode
  HOST = "http://maps.google.com"
  PATH = "/maps/api/geocode/json"
  URL = HOST + PATH

  class Error < StandardError
    attr_accessor :location, :status

    def initialize(location, status)
      @location = location
      @status = status
      super("[Geocode] failed with status #{status}")
    end
  end

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
    return [nil, nil] if location.blank?
    response = get_response(location)
    check_status(location, response.status)
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

  def check_status(location, status)
    if status != 200
      error = Geocode::Error.new(location, status)
      Rails.logger.error error.message
      raise error
    end
  end

  def parse_json(body)
    ActiveSupport::JSON.decode(body)
  end

  def first_location(json)
    results = json["results"]
    return {} if results.blank?
    results.first["geometry"]["location"]
  end
end
