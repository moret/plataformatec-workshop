require 'spec_helper'

describe "Comments" do
  before :each do
    @post = Factory.create(:post)
  end

  describe "on create" do
    it "should succed" do
      visit post_path(@post)

      fill_in "Comment", :with => "Post rulez!"
      click_link "Create comment"

      page.should have_content("Your comment was successfully added to the post.")
      page.should have_content("Post rulez!")
      post.current_path.should == post_patch(@post)
    end
  end
end