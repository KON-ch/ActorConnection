class AddLikeRefToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :like, foreign_key: true
  end
end
