class Review < ApplicationRecord
  belongs_to :user
  belongs_to :theater, optional: true
  belongs_to :movie, optional: true
  belongs_to :stage, optional: true
  has_many :posts, dependent: :destroy
  
  validates :content, presence: true
  validates :content, length: { maximum: 170 }

  acts_as_likeable

  scope :set_theaters, -> { where.not(theater_id: nil).order(updated_at: :desc) }
  scope :set_movies, -> { where.not(movie_id: nil).order(updated_at: :desc) }
  scope :set_stages, -> { where.not(stage_id: nil).order(updated_at: :desc) }

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
