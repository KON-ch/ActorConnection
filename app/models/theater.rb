class Theater < ApplicationRecord
  has_many :stages
  has_many :reviews
  acts_as_likeable

  PER = 5

  scope :display_list, -> (page) { page(page).per(PER) }
  scope :sort_theaters, -> (sort_order, page) { order(sort_order[:sort]).display_list(page) }

  scope :sort_list, -> {
    {
      "並び替え" => "",
      "投稿の新しい順" => "updated_at desc",
      "投稿の古い順" => "updated_at asc",
      # "登場人数の少ない順" => "number_characters desc",
      # "登場人数の多い順" => "number_characters asc",
    }
  }

  def number_characters
    theater.man + theater.female
  end

  def reviews_new
    reviews.new
  end
end
