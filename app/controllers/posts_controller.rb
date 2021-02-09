class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.eager_load(:theater, :movie, :stage, :like, :review, :user).display_list(params[:page])
    all_posts = Post.all
    theater_reviews = current_user.reviews.where(theater_id: all_posts.pluck(:theater_id))
    @theater_review = theater_reviews.index_by(&:theater_id)
  end
end
