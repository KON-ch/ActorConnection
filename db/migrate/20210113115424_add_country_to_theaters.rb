class AddCountryToTheaters < ActiveRecord::Migration[6.0]
  def change
    add_reference :theaters, :country, foreign_key: true
  end
end
