class Post < ApplicationRecord
  belongs_to :user
  belongs_to :theater, optional: true
  belongs_to :stage, optional: true
  belongs_to :movie, optional: true
  belongs_to :like, optional: true
  belongs_to :review, optional: true

  default_scope -> { order(created_at: :desc)}

  extend DisplayList

  def reviews_new
    reviews.new
  end

end
