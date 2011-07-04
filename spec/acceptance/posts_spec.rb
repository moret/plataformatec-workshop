require 'spec_helper'

describe "Posts" do
  describe "on create" do
    it "should succed", :driver => :selenium do
      visit posts_path
      click_link "New Post"

      fill_in "Title", :with => "My frist post"
      fill_in "Body", :with => "Hello World!"
      click_button "Create Post"

      page.should have_content("My frist post")
      page.should have_content("Hello World!")
    end
  end
end
