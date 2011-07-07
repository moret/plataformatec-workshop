require "spec_helper"

describe Geocode do
  describe ".get" do
    it "should return lat and lng for given location" do
      stub_geocode!("Rio de Janeiro, Brasil")
      Geocode.get("Rio de Janeiro, Brasil").should == [-22.9035393, -43.2095869]
    end

    it "should return [nil, nil] if address is blank" do
      Geocode.get("").should == [nil, nil]
    end

    it "should return [nil, nil] if address is unknown" do
      stub_geocode!("No place known by man, Nowhereland")
      Geocode.get("No place known by man, Nowhereland").should == [nil, nil]
    end

    it "should raise an error if result is not 200" do
      stub_geocode!("Bad Place", 500)
      begin
        Geocode.get("Bad Place")
        raise "Should never get here"
      rescue Geocode::Error => e
        e.status.should == 500
        e.message.should == "[Geocode] failed with status 500"
      end
    end
  end
end
