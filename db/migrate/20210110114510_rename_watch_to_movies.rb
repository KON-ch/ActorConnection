class RenameWatchToMovies < ActiveRecord::Migration[6.0]
  def change
    rename_column :movies, :watch, :viewing
  end
end
