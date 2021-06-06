class CreateMatinees < ActiveRecord::Migration[6.0]
  def change
    create_table :matinees do |t|
      t.date :performance_date

      t.timestamps
    end
  end
end
