class AddSynopsisToStages < ActiveRecord::Migration[6.0]
  def change
    add_column :stages, :synopsis, :text
    add_column :stages, :matinee, :time
    add_column :stages, :soiree, :time
  end
end