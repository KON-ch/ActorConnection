class RemoveReferenceUserToStage < ActiveRecord::Migration[6.0]
  def change
    remove_reference :stages, :user
  end
end
