class RemoveReferenceToReview < ActiveRecord::Migration[6.0]
  def change
    remove_reference :reviews, :theater
    add_reference :reviews, :post, null: false
    add_column :reviews, :viewing, :integer
    change_column :reviews, :user_id, :integer, null: false
  end
end
