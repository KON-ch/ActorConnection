class RenameGroupColumnToCompany < ActiveRecord::Migration[6.0]
  def change
    rename_column :stages, :group, :company
  end
end
