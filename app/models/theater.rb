class Theater < ApplicationRecord
  has_many :stages
  has_one :post, dependent: :destroy, touch: true
  belongs_to :country

  validates :title, :writer, :country_id, presence: true
  validates :title, presence: true, uniqueness: {scope: :writer, message:"この作品は既に作成されています"}
  validates :man, numericality: { only_integer: true }, allow_nil: true
  validates :female, numericality: { only_integer: true}, allow_nil: true

  extend DisplayList
  extend SortInfo

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

end
