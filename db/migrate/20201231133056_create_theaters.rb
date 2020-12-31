class CreateTheaters < ActiveRecord::Migration[6.0]
  def change
    create_table :theaters do |t|
      t.string :title, null: false
      t.string :writer, null: false
      t.string :country, null: false
      t.integer :man
      t.integer :female
      t.string :translator
      t.string :record, null: false
      t.string :publication, null: false
      t.integer :stage_id

      t.timestamps
    end
  end
end
