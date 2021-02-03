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
    if review.save_review(review, review_params)
      redirect_page
      flash[:notice] = "レビューを作成しました"
    else
      redirect_page
      flash[:alert] = "投稿に失敗しました"
    end
  end

  def update
    if params[:theater_id].present?
      theater = params[:theater_id]
      review = Review.find_by(user: current_user, theater_id: theater)
    elsif params[:movie_id].present?
      movie = params[:movie_id]
      review = Review.find_by(user: current_user, movie_id: movie)
    elsif params[:stage_id].present?
      stage = params[:stage_id]
      review = Review.find_by(user: current_user, stage_id: stage)
    elsif params[:post_id].present?
      post = params[:post_id]
      review = Review.find_by(user: current_user, post_id: post)
    end
    if review.update_attributes(review_params)
      redirect_to page_params[:review_page]
      flash[:notice] = "レビューを編集しました"
    else
      redirect_to page_params[:review_page]
      flash[:alert] = "編集に失敗しました"
    end
  end

  def destroy
    if params[:theater_id].present?
      review = Review.find_by(user: current_user, theater_id: params[:theater_id])
    elsif params[:movie_id].present?
      review = Review.find_by(user: current_user, movie_id: params[:movie_id])
    elsif params[:stage_id].present?
      review = Review.find_by(user: current_user, stage_id: params[:stage_id])
    elsif params[:post_id].present?
      review = Review.find_by(user: current_user, stage_id: params[:stage_id])
    end
    review.destroy
    redirect_to posts_path
    flash[:notice] = "レビューを削除しました"
    end

  def favorite
    @review = Review.find(params[:id])
    current_user.toggle_like!(@review)
    @review.reload
  end

  private
    def review_params
      params.require(:review).permit(:content).merge(user_id: current_user.id, theater_id: params[:theater_id], movie_id: params[:movie_id], stage_id: params[:stage_id], post_id: params[:post_id])
    end

    def page_params
      params.require(:review).permit(:review_page)
    end

    def redirect_page
      if page_params[:review_page].include?('post')
        redirect_to posts_path
      else
        redirect_to page_params[:review_page]
      end
    end

end
