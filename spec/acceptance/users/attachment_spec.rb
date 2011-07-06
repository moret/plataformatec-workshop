require 'spec_helper'

describe "[User] Attachments" do
  before(:each) do
    @user = Factory.create(:user)
    sign_user_in_manually @user
  end

  describe "on create" do
    it "should succed if valid post and attachment provided" do
      visit new_post_path

      fill_in "Title", :with => "My frist post"
      fill_in "Body", :with => "Hello World!"

      within "#attachment_forms .attachment_form:nth-child(1)" do
        fill_in "Name", :with => "Rails Logo"
        attach_file "Attachment", "spec/fixtures/rails.png"
      end

      click_button "Create Post"

      page.should have_content("My frist post")
      click_link "Rails Logo"
      page.current_path.should =~ %r(/uploads/attachment/attachment/\d+/rails\.png)
    end
  end
end
