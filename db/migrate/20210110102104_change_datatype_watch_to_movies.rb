class ChangeDatatypeWatchToMovies < ActiveRecord::Migration[6.0]
  def change
    change_column :movies, :watch, :integer, null: false
  end
end
