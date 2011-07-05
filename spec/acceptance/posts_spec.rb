require 'spec_helper'

describe "Posts" do
  describe "on create" do
    it "should succed if valid", :driver => :selenium do
      visit posts_path
      click_link "New Post"

      fill_in "Title", :with => "My frist post"
      fill_in "Body", :with => "Hello World!"
      click_button "Create Post"

      page.should have_content("My frist post")
      page.should have_content("Hello World!")
    end

    it "should fail if invalid", :driver => :selenium do
      visit new_post_path

      click_button "Create Post"

      page.should have_content("Some errors were found, please take a look")
      page.should have_content("can't be blank")
    end
  end
end
