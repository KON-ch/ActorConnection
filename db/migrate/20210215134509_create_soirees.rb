class CreateSoirees < ActiveRecord::Migration[6.0]
  def change
    create_table :soirees do |t|
      t.date :performance_date, null: false
      t.timestamps
    end
  end
end
