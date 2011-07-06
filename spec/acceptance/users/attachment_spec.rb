require 'spec_helper'

describe "[User] Attachments" do
  let(:attachment_href_regex) do
    %r(/uploads/attachment/attachment/\d+/rails\.png)
  end

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
      have_link_with_href "Rails Logo", attachment_href_regex
    end

    it "should cache files when there is a mistake" do
      visit new_post_path

      within "#attachment_forms .attachment_form:nth-child(3)" do
        fill_in "Name", :with => "Rails Logo"
        attach_file "Attachment", "spec/fixtures/rails.png"
      end

      click_button "Create Post"

      # Should not be created because of validation
      have_link_with_href "Rails Logo", %r(/uploads/tmp/[\w\-]+/rails\.png)

      # Fill in missing data and create a new upload
      fill_in "Title", :with => "My frist post"
      fill_in "Body", :with => "Hello World!"      

      within "#attachment_forms .attachment_form:nth-child(2)" do
        fill_in "Name", :with => "Another Rails Logo"
        attach_file "Attachment", "spec/fixtures/rails.png"
      end

      click_button "Create Post"
      have_link_with_href "Rails Logo", attachment_href_regex
      have_link_with_href "Another Rails Logo", attachment_href_regex
    end
  end

  protected

  def have_link_with_href(name, href)
      link = find("a", :text => name)
      link["href"].should =~ href
  end

end
