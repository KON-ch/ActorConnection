class AddColumnToStages < ActiveRecord::Migration[6.0]
  def change
    add_column :stages, :image, :string
    add_column :stages, :director, :string
    add_column :stages, :quote, :string
  end
end
