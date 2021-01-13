class RemoveCountryFromTheaters < ActiveRecord::Migration[6.0]
  def change
    remove_column :theaters, :country
  end
end
