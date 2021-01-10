class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.integer :latitude
      t.integer :longitude
      t.string :access

      t.timestamps
    end
  end
end
