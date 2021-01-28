class ChangeLatitudeLongitudeToPlaces < ActiveRecord::Migration[6.0]
  def change
    change_column :places, :longitude, :float
    change_column :places, :latitude, :float
  end
end
