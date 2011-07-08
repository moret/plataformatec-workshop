require "spec_helper"

describe "[Guest] Posts slugs" do
  before(:each) do
    @post = Factory.create(:post, :slug => "slug_abcd")
  end

  it "should redirect based on /r/* slugs" do
    visit "/r/slug_abcd"

    page.should have_content("My frist post")

    expect {
      visit "/r/unknown"
    }.to raise_error(ActionController::RoutingError)
  end

  it "should redirect based on /m/* slugs" do
    visit "/m/slug_abcd"

    page.should have_content("My frist post")

    expect {
      visit "/m/unknown"
    }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "should redirect based on c.host/* slugs" do
    Capybara.default_host = "http://c.example.com"
    visit "/slug_abcd"

    page.should have_content("My frist post")

    expect {
      visit "/unknown"
    }.to raise_error(ActiveRecord::RecordNotFound)
  end

  after(:each) do
    Capybara.default_host = "http://www.example.com"
  end
end
