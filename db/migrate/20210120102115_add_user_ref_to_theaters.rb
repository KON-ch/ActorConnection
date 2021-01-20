class AddUserRefToTheaters < ActiveRecord::Migration[6.0]
  def change
    add_reference :theaters, :user, foreign_key: true
  end
end
