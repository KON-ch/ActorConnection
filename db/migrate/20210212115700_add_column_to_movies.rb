class AddColumnToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :screen_time, :integer
    add_column :movies, :quote, :string
    add_column :movies, :quote_url, :string
  end
end
