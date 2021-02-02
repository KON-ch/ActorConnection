class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.display_list(params[:page])
  end

end
