class RemoveColumnFromTheater < ActiveRecord::Migration[6.0]
  def change
    remove_column :theaters, :translator, :string
    remove_column :theaters, :include, :string
    remove_column :theaters, :publication, :string
  end
end
