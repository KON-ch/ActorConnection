class AddSynopsisToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :synopsis, :string
  end
end
