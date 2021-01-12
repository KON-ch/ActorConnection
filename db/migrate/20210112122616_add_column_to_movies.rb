class AddColumnToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :sub_title, :string
    add_column :movies, :supervision, :string
  end
end
