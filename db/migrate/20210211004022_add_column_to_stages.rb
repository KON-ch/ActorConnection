class AddColumnToStages < ActiveRecord::Migration[6.0]
  def change
    add_column :stages, :synopsis, :text
  end
end
