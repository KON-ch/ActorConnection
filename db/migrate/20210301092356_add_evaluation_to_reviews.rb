class AddEvaluationToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :rate, :float, null: false
  end
end
