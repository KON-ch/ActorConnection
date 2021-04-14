class CreatePlices < ActiveRecord::Migration[6.0]
  def change
    create_table :plices do |t|
      t.integer :name, null: false
      t.integer :fee, null: false

      t.timestamps
    end
  end
end
