require 'spec_helper'

describe Post do
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
end
