class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.includes(:theater, :movie, :stage, :review, :like, :user).display_list(params[:page])
  end

end
