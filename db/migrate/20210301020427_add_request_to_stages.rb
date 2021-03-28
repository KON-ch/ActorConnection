# frozen_string_literal: true

class AddRequestToStages < ActiveRecord::Migration[6.0]
  def change
    add_column :stages, :request, :boolean, default: false, null: false
  end
end
