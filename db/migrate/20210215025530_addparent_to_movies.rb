class AddparentToMovies < ActiveRecord::Migration[6.0]
  def change
    add_reference :movies, :parent
  end
end
