class Movie < ApplicationRecord
  belongs_to :user
  belongs_to :country

  validates :title, presence: true
  acts_as_likeable

  extend DisplayList
  extend SortInfo

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
end
