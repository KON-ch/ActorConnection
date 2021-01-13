class Movie < ApplicationRecord
  belongs_to :user
  belongs_to :country

  validates :title, presence: true

  enum viewing: { "映画館": 0, "その他": 9}

  extend DisplayList
  extend SortInfo

  scope :sort_list, -> {
    {
      "並び替え" => "",
      "投稿の新しい順" => "updated_at desc",
      "投稿の古い順" => "updated_at asc"
    }
  }
end
