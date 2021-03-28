# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.new(review_params)
    if review.save
      redirect_page
      flash[:notice] = 'レビューを作成しました'
    else
      redirect_page
      flash[:alert] = 'レビューに失敗しました'
    end
  end

  def update
    review = Review.find(params[:id])
    if review.update(review_params.merge(post_id: review.post_id, theater_id: review.theater_id,
                                         movie_id: review.movie_id, stage_id: review.stage_id))
      redirect_to page_params[:review_page]
      flash[:notice] = 'レビューを編集しました'
    else
      redirect_to page_params[:review_page]
      flash[:alert] = '編集に失敗しました'
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to params[:review_page]
    flash[:notice] = 'レビューを削除しました'
  end

  def favorite
    @review = Review.find(params[:id])
    current_user.toggle_like!(@review)
    @review.reload
  end

  private

  def review_params
    params.require(:review).permit(:content, :rate).merge(user_id: current_user.id, theater_id: params[:theater_id],
                                                          movie_id: params[:movie_id], stage_id: params[:stage_id], post_id: params[:post_id])
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
