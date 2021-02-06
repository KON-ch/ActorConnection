class Review < ApplicationRecord
  belongs_to :user
  belongs_to :theater, -> { includes :country }, inverse_of: :reviews, optional: true
  belongs_to :movie, -> { includes :country }, inverse_of: :reviews, optional: true
  belongs_to :stage, -> { includes :theater }, inverse_of: :reviews, optional: true
  has_many :posts, dependent: :destroy

  validates :content, presence: true
  validates :content, length: { maximum: 170 }

  acts_as_likeable

  scope :set_theaters, -> { where.not(theater_id: nil).order(updated_at: :desc) }
  scope :set_movies, -> { where.not(movie_id: nil).order(updated_at: :desc) }
  scope :set_stages, -> { where.not(stage_id: nil).order(updated_at: :desc) }

  def self.check_user_review(user, post)
    if post.instance_of?(Theater)
      where(user_id: user.id, theater_id: post.id)
    elsif post.instance_of?(Movie)
      where(user_id: user.id, movie_id: post.id)
    elsif post.instance_of?(Stage)
      where(user_id: user.id, stage_id: post.id)
    end
  end

  after_commit :create_post, on: [:create]

  private

  def create_post
    post = Post.new(review_id: id, user_id: user_id)
    post.save
  end
end
