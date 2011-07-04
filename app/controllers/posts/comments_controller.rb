class Posts::CommentsController < ApplicationController
  before_filter :find_post

  def create
    @comment = @post.comments.build(params[:comment])
    @comment.save
    respond_with(@post, @comment, :location => @post)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end