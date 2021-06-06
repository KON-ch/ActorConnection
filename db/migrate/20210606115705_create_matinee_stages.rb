class CreateMatineeStages < ActiveRecord::Migration[6.0]
  def change
    create_table :matinee_stages do |t|
      t.belongs_to :stage, index: true, foreign_key: true
      t.belongs_to :matinee, index: true, foreign_key: true

      t.timestamps
    end
  end
end
