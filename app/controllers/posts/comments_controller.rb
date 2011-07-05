class Posts::CommentsController < ApplicationController
  before_filter :find_post
  respond_to :html, :js

  def create
    @comment = @post.comments.build(params[:comment])
    respond_with(@post, @comment, :location => @post) do |format|
      format.html { render "posts/show" } unless @comment.save
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end