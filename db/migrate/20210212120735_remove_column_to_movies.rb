class RemoveColumnToMovies < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :quote, :string
    remove_column :stages, :quote, :string
  end
end
