class AddRefToMatineestages < ActiveRecord::Migration[6.0]
  def change
    add_reference :matinee_stages, :matinee, index: true
    add_reference :matinee_stages, :stage, index: true
  end
end
