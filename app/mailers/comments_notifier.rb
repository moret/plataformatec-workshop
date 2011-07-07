class CommentsNotifier < ActionMailer::Base
  default :from => "no-reply@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comments_notifier.to_post_author.subject
  #
  def to_post_author(comment)
    @comment = comment
    @post = @comment.post
    @author = @post.user

    attachments["comments.txt"] = comment.body

    mail :to => @author.email,
      :subject => "A new comment was added to #{@post.title}"
  end
end
