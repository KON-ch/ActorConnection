class RemoveCountryFromMovies < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :country
  end
end
