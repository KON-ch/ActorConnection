class RemoveUserIdToTheaters < ActiveRecord::Migration[6.0]
  def change
    remove_column :theaters, :user_id, :integer
    remove_column :theaters, :stage_id, :integer
    add_reference :theaters, :user, foreign_key: true
  end
end
