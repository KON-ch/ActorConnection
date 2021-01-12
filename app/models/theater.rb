class Theater < ApplicationRecord
  has_many :stages, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :user

  validates :title, :writer, :country, presence: true
  validates :man, numericality: { only_integer: true }, allow_nil: true
  validates :female, numericality: { only_integer: true}, allow_nil: true
  acts_as_likeable

  extend DisplayList
  extend SortInfo

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
