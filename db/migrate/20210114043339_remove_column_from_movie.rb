class RemoveColumnFromMovie < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :viewing, :integer
  end
end
