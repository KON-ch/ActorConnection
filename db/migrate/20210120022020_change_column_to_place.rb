class ChangeColumnToPlace < ActiveRecord::Migration[6.0]
  def change
    change_column :places, :name, :string, unipue: true
  end
end
