class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    theater = Theater.find(params[:theater_id])
    review = theater.reviews_new
    review.save_review(review, review_params)
    redirect_to theaters_path, , notice: "レビューを投稿しました" 
  end

  private
    def review_params
      params.require(:review).permit(:content).merge(user_id: current_user.id, theater_id: params[:theater_id])
    end
end
