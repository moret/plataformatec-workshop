# require "spec_helper"

# describe "[Guest] Posts slugs" do
#   before(:each) do
#     @post = Factory.create(:post, :slug => "slug_abcd")
#   end

#   it "should redirect based on /r/* slugs" do
#     visit "/r/abcd"

#     page.should have_content("My frist post")

#     expect {
#       visit "/r/unknown"
#     }.to raise_error(ActionController::RoutingError)
#   end
# end
