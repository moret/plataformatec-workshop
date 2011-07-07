require 'spec_helper'

describe Post do
  let(:location){ "Rio de Janeiro, Brasil" }

  describe "validations" do
    it "should raise an error if no user is given" do
      expect {
        Factory.create(:post, :user => nil)
      }.to raise_error(RuntimeError, "@post.user is nil")
    end
  end

  describe "#is_author?" do
    it "should return a boolean if the user is the author" do
      user = Factory.create(:user)
      post = Factory.create(:post, :user => user)
      another_user = Factory.create(:user)

      post.is_author?(user).should be
      post.is_author?(another_user).should_not be
    end

    it "should return false if the user is nil" do
      post = Factory.create(:post)
      post.is_author?(nil).should_not be
    end
  end

  describe "on create" do
    it "should store author's lat and lng" do
      stub_geocode!(location)
      post = Factory.create(:post, :location => location)
      post.location.should == location
      [post.lat, post.lng].should == [-22.9035393, -43.2095869]
    end

    it "should not store author's lat and lng if server unavailable" do
      stub_geocode!(location, 500)
      post = Factory.create(:post, :location => location)
      post.location.should == location
      [post.lat, post.lng].should == [nil, nil]
    end

    it "should default lat and lng to nil" do
      post = Factory.create(:post)
      [post.lat, post.lng].should == [nil, nil]
    end
  end

  describe "on update" do
    it "should store author's lat and lng" do
      post = Factory.create(:post)

      stub_geocode!(location)
      post.update_attributes(:location => location)
      [post.lat, post.lng].should == [-22.9035393, -43.2095869]
    end
  end
end
