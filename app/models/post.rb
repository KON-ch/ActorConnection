class Post < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  belongs_to :theater, optional: true
  belongs_to :stage, optional: true
  belongs_to :movie, optional: true

  acts_as_likeable

  default_scope -> { order(created_at: :desc)}

  def reviews_new
    reviews.new
  end

end
