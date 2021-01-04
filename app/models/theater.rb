class Theater < ApplicationRecord
  has_many :stages
  has_many :reviews

  def reviews_new
    reviews.new
  end
end
