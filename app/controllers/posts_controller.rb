class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all
    respond_with(@posts)
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    respond_with(@post)
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = current_user.posts.build
    respond_with(@post)
  end

  # GET /posts/1/edit
  def edit
    @post = current_user.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = current_user.posts.build(params[:post])
    @post.save
    respond_with(@post)
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = current_user.posts.find(params[:id])
    @post.update_attributes(params[:post])
    respond_with(@post)
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    respond_with(@post)
  end
end
