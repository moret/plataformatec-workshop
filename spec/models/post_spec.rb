require 'spec_helper'

describe Post do
  describe "validations" do
    it "should raise an error if no user is given" do
      expect {
        Factory.create(:post, :user => nil)
      }.to raise_error(RuntimeError, "@post.user is nil")
    end
  end
end
