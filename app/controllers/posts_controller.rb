class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.includes(:theater, :movie, :stage, :review, :like, :user).all
  end

  def favorite
    @post = Post.find(params[:id])
    current_user.toggle_like!(@post)
  end

end