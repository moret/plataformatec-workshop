require 'spec_helper'

describe Comment do
  describe "on create" do
    it "should send email to author" do
      user = Factory.create(:user)
      post = Factory.create(:post, :user => user)

      expect {
        Factory.create(:comment, :post => post)
      }.to change(ActionMailer::Base.deliveries, :size).by(1)

      mail = ActionMailer::Base.deliveries.last
      mail.to.should == [post.user.email]
    end
  end
end
