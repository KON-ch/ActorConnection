class AddIndexToStage < ActiveRecord::Migration[6.0]
  def change
    add_index :stages, [:theater_id, :start_date], unique: true
  end
end
