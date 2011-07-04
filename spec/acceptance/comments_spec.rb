require 'spec_helper'

describe "Comments" do
  before :each do
    @post = Factory.create(:post)
  end

  describe "on create" do
    it "should succed" do
      visit post_path(@post)

      fill_in "My comment", :with => "Post rulez!"
      click_button "Create Comment"

      page.should have_content("Your comment was successfully added to the post.")
      page.should have_content("Post rulez!")
      page.current_path.should == post_path(@post)
    end
  end
end