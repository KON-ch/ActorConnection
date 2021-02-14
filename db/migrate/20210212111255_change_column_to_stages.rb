class ChangeColumnToStages < ActiveRecord::Migration[6.0]
  def change
    remove_column :stages, :image, :string
    add_column :stages, :quote_url, :string
  end
end
