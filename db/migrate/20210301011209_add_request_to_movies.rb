class AddRequestToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :request, :boolean, default: false, null: false
  end
end
