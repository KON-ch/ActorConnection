class AddReviewRefToPost < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :review, foreign_key: true
  end
end
