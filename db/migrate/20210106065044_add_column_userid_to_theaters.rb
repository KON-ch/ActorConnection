class AddColumnUseridToTheaters < ActiveRecord::Migration[6.0]
  def change
    add_column :theaters, :user_id, :integer
  end
end
