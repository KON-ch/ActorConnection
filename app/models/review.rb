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
  scope :theaters, ->(theaters) { where(theater_id: theaters.pluck(:id)).index_by(&:theater_id) }
  scope :movies, ->(movies) { where(movie_id: movies.pluck(:id)).index_by(&:movie_id) }
  scope :stages, ->(stages) { where(stage_id: stages.pluck(:id)).index_by(&:stage_id) }

  after_commit :create_post, on: [:create]

  private

  def create_post
    post = Post.new(review_id: id, user_id: user_id)
    post.save
  end
end
