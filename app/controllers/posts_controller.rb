class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all
  end

  def favorite
    @post = Post.find(params[:id])
    @theater = Theater.find(params[:id])
    current_user.toggle_like!(@post)
  end

end
