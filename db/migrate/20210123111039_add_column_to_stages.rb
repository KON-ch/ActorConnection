class AddColumnToStages < ActiveRecord::Migration[6.0]
  def change
    add_column :stages, :likers_count, :integer, default: 0
  end
end
