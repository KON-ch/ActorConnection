class RemoveColumnUserToTheaters < ActiveRecord::Migration[6.0]
  def change
    remove_reference :theaters, :user
  end
end
