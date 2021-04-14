class RemoveChargeToFee < ActiveRecord::Migration[6.0]
  def change
    remove_column :fees, :charge 
  end
end
