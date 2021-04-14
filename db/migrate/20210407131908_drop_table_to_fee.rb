class DropTableToFee < ActiveRecord::Migration[6.0]
  def change
    drop_table :plices
    drop_table :stage_fees
    drop_table :stage_plices
    drop_table :fee_plices
    drop_table :fees
  end
end
