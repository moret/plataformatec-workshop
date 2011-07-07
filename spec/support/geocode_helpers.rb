require "spec_helper"

module GeocodeHelpers
  PLACES = {
    "Rio de Janeiro, Brasil" => File.read('spec/fixtures/rj.json'),
    "No place known by man, Nowhereland" => '{"results": []}'
  }
  
  def stub_geocode!(address, status=nil)
    connection = Faraday::Connection.new do |b|
      b.adapter(:test) do |stubs|
        escaped_address = Faraday::Utils.escape(address)
        body = PLACES[address]
        url = "#{Geocode::PATH}?address=#{escaped_address}&sensor=false"
        stubs.get(url) { [status || 200, { "Content-Type" => "json" }, body] }
      end
    end
    Faraday.default_connection = connection
  end
end
