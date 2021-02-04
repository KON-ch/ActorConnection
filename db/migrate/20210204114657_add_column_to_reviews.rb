class AddColumnToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :likers_count, :integer, :default => 0
  end
end
