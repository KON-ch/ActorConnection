class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all

    @reviews = @movie.reviews
    @review = @reviews.new
  end

  def create
    post = Post.new(post_params)
    post.save
  end

  private
    def post_params
      params.require(:post).permit(:theater_id, :stage_id, :movie_id).merge(user_id: current_user.id)
    end

end
