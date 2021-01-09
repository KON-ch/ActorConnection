class RemoveUserIdToStages < ActiveRecord::Migration[6.0]
  def change
    remove_column :stages, :user_id, :integer
    add_reference :stages, :user, foreign_key: true
  end
end
