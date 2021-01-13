class AddCountryIdToMovie < ActiveRecord::Migration[6.0]
  def change
    add_reference :movies, :country, foreign_key: true
  end
end
