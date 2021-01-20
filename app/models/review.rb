class Review < ApplicationRecord
  validates :content, presence: true
  belongs_to :post
  belongs_to :user

  def save_review(review, review_params)
    review.content = review_params[:content]
    review.user_id = review_params[:user_id]
    review.post_id = review_params[:post_id]
    save
  end
end
