class AddPlaceIdToStages < ActiveRecord::Migration[6.0]
  def change
    add_reference :stages, :place, foreign_key: true
  end
end
