require "spec_helper"

describe Geocode do
  PLACES = {
    "Rio de Janeiro, Brasil" => File.read('spec/fixtures/rj.json'),
    "Zimbabwe" => File.read('spec/fixtures/zimbabwe.json')
  }

  def stub_geocode
    connection = Faraday::Connection.new do |b|
      b.adapter(:test) do |stubs|
        PLACES.keys.each do |address|
          escaped_address = Faraday::Utils.escape(address)
          url = "#{Geocode::PATH}?address=#{escaped_address}&sensor=false"
          body = PLACES[address]
          stubs.get(url) { [200, { "Content-Type" => "json" }, body] }
        end
      end
    end
    Faraday.default_connection = connection
  end

  before(:all) do
    stub_geocode
  end

  describe ".get" do
    it "should return lat and lng for given location" do
      Geocode.get("Rio de Janeiro, Brasil").should == [-22.9035393, -43.2095869]
      Geocode.get("Zimbabwe").should == [-19.015438, 29.154857]
    end
  end
end
