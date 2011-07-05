require 'spec_helper'

describe "Comments" do
  before :each do
    @post = Factory.create(:post)
  end

  let(:success_message) do
    "Your comment was successfully added to the post."
  end

  let(:failure_message) do
    "Some errors were found, please take a look:"
  end

  describe "on create" do
    it "should succed if valid" do
      visit post_path(@post)

      fill_in "My comment", :with => "Post rulez!"
      click_button "Create Comment"

      page.should have_content(success_message)
      page.should have_content("Post rulez!")
      page.current_path.should == post_path(@post)
    end

    it "should succed if valid with Ajax", :js => true do
      visit post_path(@post)

      fill_in "My comment", :with => "Ajax Post rulez!"
      click_button "Create Comment"

      within @post.comments.last do
        page.should have_content("Ajax Post rulez!")
      end

      page.should_not have_content(success_message)
      page.should have_css("#new_comment textarea", :text => "")
    end

    it "should fail if invalid" do
      visit post_path(@post)

      click_button "Create Comment"

      page.should have_content(failure_message)
      page.should have_content("can't be blank")
      page.current_path.should == post_comments_path(@post)
    end

    it "should fail if invalid with Ajax", :js => true do
      visit post_path(@post)

      click_button "Create Comment"

      page.should have_content(failure_message)
      page.should have_content("can't be blank")
      page.current_path.should == post_path(@post)
    end
  end
end
