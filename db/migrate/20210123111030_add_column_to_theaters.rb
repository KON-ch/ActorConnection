class AddColumnToTheaters < ActiveRecord::Migration[6.0]
  def change
    add_column :theaters, :likers_count, :integer, default: 0
  end
end
