require "spec_helper"

describe "[Guest] Posts" do
  describe "on create" do
    it "should be redirected to sign in page" do
      visit new_post_path
      page.current_path.should == new_user_session_path
      page.should have_content "You need to sign in or sign up before continuing"
    end
  end

  describe "when listed" do
    before(:each) do
      Factory.create(:post, :created_at => 10.days.ago)
      Factory.create(:post, :title => "Another title")
    end

    it "should show more recent first" do
      visit posts_path

      within "#posts" do
        within "tr:nth-child(2)" do
          page.should have_content("Another title")
        end

        within "tr:nth-child(3)" do
          page.should have_content("My frist post")
        end
      end
    end
  end
end
