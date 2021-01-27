class Theater < ApplicationRecord
  has_many :stages, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :posts, dependent: :destroy
  belongs_to :country
  belongs_to :user
  
  acts_as_likeable

  validates :title, :writer, :country_id, presence: true
  validates :title, presence: true, uniqueness: {scope: :writer, message:"この作品は既に作成されています"}
  validates :man, numericality: { only_integer: true }, allow_nil: true
  validates :female, numericality: { only_integer: true }, allow_nil: true

  extend DisplayList
  extend SortInfo

  default_scope -> { order(created_at: :desc)}

  scope :country_theaters, -> (country) {
    where(country_id: country)
  }

  scope :search_theaters, -> (keyword) {
    where("title LIKE ? OR writer LIKE ?", "%#{keyword}%", "%#{keyword}%")
  }

  scope :sort_list, -> {
    {
      "並び替え" => "",
      "投稿の新しい順" => "updated_at desc",
      "投稿の古い順" => "updated_at asc",
    }
  }

  def reviews_new
    reviews.new
  end

  after_commit :create_post, on: [:create]

  private
    def create_post
      post = Post.new(theater_id: self.id, user_id: self.user_id)
      post.save
    end

end
