require "spec_helper"

describe CommentsNotifier do
  describe "to_post_author" do
    let(:user) { Factory.create(:user) }
    let(:post) { Factory.create(:post, :user => user) }
    let(:comment) { Factory.create(:comment, :post => post) }
    let(:mail) { CommentsNotifier.to_post_author(comment) }

    it "renders the headers" do
      mail.subject.should eq("A new comment was added to #{post.title}")
      mail.to.should eq([user.email])
      mail.from.should eq(["no-reply@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match(post.title)
      mail.body.encoded.should match(comment.body)
    end

    it "renders attachments" do
      mail.attachments[0].body.encoded.should eq(comment.body)
    end
  end
end
