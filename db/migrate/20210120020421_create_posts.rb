class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.references :theater, foreign_key: true
      t.references :stage, foreign_key: true
      t.references :movie, foreign_key: true
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
