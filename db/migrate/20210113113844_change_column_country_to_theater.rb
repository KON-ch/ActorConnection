class ChangeColumnCountryToTheater < ActiveRecord::Migration[6.0]
  def change
    remove_column :theaters, :country,
    add_reference :theaters, :country, null: false
  end
end
