class AddFeePliceToStage < ActiveRecord::Migration[6.0]
  def change
    remove_column :stages, :fee_plice_id, :integer
    add_reference :stages, :plice, foreign_key: true
    add_reference :stages, :fee, foreign_key: true
  end
end
