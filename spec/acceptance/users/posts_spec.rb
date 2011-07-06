require 'spec_helper'

describe "[Users] Posts" do
  before :each do
    @user = Factory.create(:user)
    sign_user_in_manually(@user)
    @post = Factory.create(:post, :user => @user)
  end

  describe "on create" do
    it "should succed if valid" do
      visit posts_path
      click_link "New Post"

      fill_in "Title", :with => "My frist post"
      fill_in "Body", :with => "Hello World!"
      click_button "Create Post"

      page.should have_content("My frist post")
      page.should have_content("Hello World!")
    end

    it "should fail if invalid" do
      visit new_post_path

      click_button "Create Post"

      page.should have_content("Some errors were found, please take a look")
      page.should have_content("can't be blank")
    end
  end

  describe "on update" do
    it "should succed if valid" do
      visit edit_post_path(@post)

      fill_in "Title", :with => "My frist post - edited"
      fill_in "Body", :with => "Hello World! Bye World..."
      click_button "Update Post"

      page.should have_content("My frist post - edited")
      @post.reload.body.should == "Hello World! Bye World..."
    end

    it "should no be available for other author" do
      another_post = Factory.create(:post)
      visit posts_path

      # Accessing @post by the @user
      within @post do
        page.should have_content("Edit")
        page.should have_content("Destroy")
      end

      # Not created by @user
      within another_post do
        page.should_not have_content("Edit")
        page.should_not have_content("Destroy")
      end

      expect {
        visit edit_post_path(another_post)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
