class CreateStagePlices < ActiveRecord::Migration[6.0]
  def change
    create_table :stage_plices do |t|
      t.belongs_to :stage, index: true, foreign_key: true
      t.belongs_to :plice, index: true, foreign_key: true

      t.timestamps
    end
  end
end
