class AddSynopsisToStages < ActiveRecord::Migration[6.0]
  def change
    add_column :stages, :synopsis, :text
    add_column :stages, :matinee, :time
    add_column :stages, :soiree, :time
  end
end

class CreateSoirees < ActiveRecord::Migration[6.0]
  def change
    create_table :sirees do |t|
      t.date :performance_date, null: false
      t.timestamps
    end
  end
end

class CreateSoireeStages < ActiveRecord::Migration[6.0]
  def change
    create_table :soiree_stages do |t|
      t.references :stage, index: true, foreign_key: true
      t.references :soiree, index: true, foreign_key: true

      t.timestamps
    end
  end
end
