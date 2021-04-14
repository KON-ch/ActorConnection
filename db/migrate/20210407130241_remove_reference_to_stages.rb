class RemoveReferenceToStages < ActiveRecord::Migration[6.0]
  def change
    remove_reference :stages, :plice
    remove_reference :stages, :fee
  end
end
