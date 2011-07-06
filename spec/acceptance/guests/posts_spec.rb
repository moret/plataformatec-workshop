require "spec_helper"

describe "[Guest] Posts" do
  describe "on create" do
    it "should be redirected to sign in page" do
      visit new_post_path
      page.current_path.should == new_user_session_path
      page.should have_content "You need to sign in or sign up before continuing"
    end
  end
end
