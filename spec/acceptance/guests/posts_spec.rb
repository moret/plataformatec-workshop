require "spec_helper"

describe "[Guest] Posts" do
  describe "on create" do
    it "should be redirected to sign in page" do
      visit new_post_path
      page.current_path.should == new_user_session_path
      page.should have_content "You need to sign in or sign up before continuing"
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
