class AddUseridToStages < ActiveRecord::Migration[6.0]
  def change
    add_column :stages, :user_id, :integer
  end
end
