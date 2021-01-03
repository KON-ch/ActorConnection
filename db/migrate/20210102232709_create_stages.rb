class CreateStages < ActiveRecord::Migration[6.0]
  def change
    create_table :stages do |t|
      t.string :group
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :theater, null: false, foreign_key: true

      t.timestamps
    end
  end
end
