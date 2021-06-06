class ChangeColumnToStage < ActiveRecord::Migration[6.0]
  def change
    remove_column :matinee_stages, :stage_id
    remove_column :matinee_stages, :matinee_id
  end
end
