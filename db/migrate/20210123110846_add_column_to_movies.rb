class AddColumnToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :likers_count, :integer, default: 0
  end
end
