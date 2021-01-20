class ChangeReferenceToReview < ActiveRecord::Migration[6.0]
  def change
    remove_reference :reviews, :posts
    add_reference :reviews, :post, null: false
  end
end
