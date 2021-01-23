class AddRefToReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :theater, foreign_key: true
    add_reference :reviews, :movie, foreign_key: true
    add_reference :reviews, :stage, foreign_key: true
  end
end
