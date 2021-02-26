class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.eager_load(:theater, :movie, :stage, :like, :review, :user).display_list(params[:page])
    all_posts = Post.all
    theater_reviews = current_user.reviews.where(theater_id: all_posts.pluck(:theater_id))
    @theater_review = theater_reviews.index_by(&:theater_id)
    movie_reviews = current_user.reviews.where(movie_id: all_posts.pluck(:movie_id))
    @movie_review = movie_reviews.index_by(&:movie_id)
    stage_reviews = current_user.reviews.where(stage_id: all_posts.pluck(:stage_id))
    @stage_review = stage_reviews.index_by(&:stage_id)
  end
end
