class RemoveReferenceToMovie < ActiveRecord::Migration[6.0]
  def change
    remove_reference :movies, :user
    change_column :movies, :country_id, :integer, null: false
  end
end
