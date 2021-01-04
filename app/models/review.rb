class Review < ApplicationRecord
  validates :content, presence: true
  belongs_to :theater
  belongs_to :user

  def save_review(review, review_params)
    review.content = review_params[:content]
    review.user_id = review_params[:user_id]
    review.theater_id = review_params[:theater_id]
    save
  end
end
