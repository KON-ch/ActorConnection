class Stage < ApplicationRecord
  belongs_to :theater
  has_many :posts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :place
  belongs_to :user

  acts_as_likeable

  validates :start_date, :end_date, :company, presence: true
  validates :theater_id, presence: true, uniqueness: {scope: :start_date, message:"この作品は既に作成されています"}

  extend DisplayList
  extend SortInfo

  scope :sort_list, -> {
    {
      "並び替え" => "",
      "開演日が近い順" => "start_date_asc",
      "開演日が遠い順" => "start_date_desc",
      "終演日が近い順" => "end_date_asc",
      "終演日が遠い順" => "end_date_desc",
    }
  }

  def reviews_new
    reviews.new
  end

  after_commit :create_post, on: [:create]

  private
    def create_post
      return if self.user_id == 1
      post = Post.new(stage_id: self.id, user_id: self.user_id)
      post.save
    end
end
