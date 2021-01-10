class Movie < ApplicationRecord
  belongs_to :user

  enum viewing: { "映画館": 0, "その他": 9}

  extend DisplayList
  extend SortOrder

  scope :sort_list, -> {
    {
      "並び替え" => "",
      "投稿の新しい順" => "updated_at desc",
      "投稿の古い順" => "updated_at asc"
    }
  }
end
