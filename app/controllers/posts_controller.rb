class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.eager_load(:theater, :movie, :stage, :like, :review, :user).display_list(params[:page])
  end
end
