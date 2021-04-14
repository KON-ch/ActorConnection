class AddFeePliceIdToStage < ActiveRecord::Migration[6.0]
  def change
    add_column :stages, :fee_plice_id, :integer, null: false, default: 0
  end
end
