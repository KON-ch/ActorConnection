class AddRecommendToMovie < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :recommend, :boolean, default: false, null: false
  end
end
