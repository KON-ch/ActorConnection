class AddIndexToMovie < ActiveRecord::Migration[6.0]
  def change
    add_index :movies, [:title, :sub_title], unique: true
  end
end
