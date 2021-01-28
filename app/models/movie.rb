class Movie < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :country
  belongs_to :user

  acts_as_likeable

  validates :title, presence: true, uniqueness: {scope: :sub_title, message:"この作品は既に作成されています"}
  
  extend DisplayList
  extend SortInfo

  default_scope -> { order(created_at: :desc)}

  scope :country_movies, -> (country) {
    where(country_id: country)
  }

  scope :search_movies, -> (keyword) {
    where("title LIKE ? OR supervision LIKE ? OR sub_title LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
  }

  scope :sort_list, -> {
    {
      "並び替え" => "",
      "投稿の新しい順" => "updated_at desc",
      "投稿の古い順" => "updated_at asc",
      "製作年の新しい順" => "production desc",
      "製作年の古い順" => "production asc"
    }
  }

  def reviews_new
    reviews.new
  end

  after_commit :create_post, on: [:create]

  private
    def create_post
      return if self.user_id == 1
      post = Post.new(movie_id: self.id, user_id: self.user_id)
      post.save
    end
end
