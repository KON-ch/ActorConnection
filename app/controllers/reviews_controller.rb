class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:theater_id].present?
      theater = Theater.find(params[:theater_id])
      review = theater.reviews_new
    elsif params[:movie_id].present?
      movie = Movie.find(params[:movie_id])
      review = movie.reviews_new
    elsif params[:stage_id].present?
      stage = Stage.find(params[:stage_id])
      review = stage.reviews_new
    elsif params[:post_id].present?
      post = Post.find(params[:post_id])
      review = post.reviews_new
    end
    review.save_review(review, review_params)
    redirect_to posts_path, notice: "レビューを投稿しました" 
  end

  private
    def review_params
      params.require(:review).permit(:content).merge(user_id: current_user.id, theater_id: params[:theater_id], movie_id: params[:movie_id], stage_id: params[:stage_id], post_id: params[:post_id])
    end
end
