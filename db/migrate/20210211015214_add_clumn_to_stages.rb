class AddClumnToStages < ActiveRecord::Migration[6.0]
  def change
    add_column :stages, :matinee, :time
    add_column :stages, :soiree, :time
  end
end
