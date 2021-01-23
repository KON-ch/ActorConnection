class ChangeColumnToReviews < ActiveRecord::Migration[6.0]
  def change
    remove_reference :reviews, :post
    add_reference :reviews, :post, foreign_key: true
  end
end
