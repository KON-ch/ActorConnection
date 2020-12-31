class RenameRecordColumnToInclude < ActiveRecord::Migration[6.0]
  def change
    rename_column :theaters, :record, :include
  end
end
