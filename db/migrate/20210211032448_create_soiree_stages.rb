class CreateSoireeStages < ActiveRecord::Migration[6.0]
  def change
    create_table :soiree_stages do |t|
      t.references :stage, index: true, foreign_key: true
      t.references :soiree, index: true, foreign_key: true

      t.timestamps
    end
  end
end
