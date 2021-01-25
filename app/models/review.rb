class Review < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :theater, optional: true
  belongs_to :movie, optional: true
  belongs_to :stage, optional: true
  has_one :post, dependent: :destroy, touch: true

  def save_review(review, review_params)
    review.content = review_params[:content]
    review.user_id = review_params[:user_id]
    if post_id.present?
      review.post_id = review_params[:post_id]
    elsif theater_id.present?
      review.theater_id = review_params[:theater_id]
    elsif movie_id.present?
      review.movie_id = review_params[:movie_id]
    elsif stage_id.present?
      review.stage_id = review_params[:stage_id]
    end
    save
  end

  def self.check_user_review(user, post)
    if post.class == Theater
      if where(user_id: user.id, theater_id: post.id).count > 0
        return false
      else
        return true
      end
    elsif post.class == Movie
      if where(user_id: user.id, movie_id: post.id).count > 0
        return false
      else
        return true
      end
    elsif post.class == Stage
      if where(user_id: user.id, stage_id: post.id).count > 0
        return false
      else
        return true
      end
    end
  end

  after_commit :create_post, on: [:create]

  private
    def create_post
      post = Post.new(review_id: self.id, user_id: self.user_id)
      post.save
    end

end
