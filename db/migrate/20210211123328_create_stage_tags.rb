class CreateStageTags < ActiveRecord::Migration[6.0]
  def change
    create_table :stage_tags do |t|
      t.references :stage, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
