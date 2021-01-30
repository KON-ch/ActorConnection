class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.includes(:theater, :movie, :stage, :review, :like, :user).all
  end

end
