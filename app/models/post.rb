class Post < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  belongs_to :theater
  belongs_to :stage
  belongs_to :movie

  acts_as_likeable

  def reviews_new
    reviews.new
  end

end
