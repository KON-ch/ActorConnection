class AddIndexToTheater < ActiveRecord::Migration[6.0]
  def change
    add_index :theaters, [:title, :writer], unique: true
  end
end
