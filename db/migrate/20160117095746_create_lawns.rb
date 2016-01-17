class CreateLawns < ActiveRecord::Migration
  def change
    create_table :lawns do |t|
      t.integer :width, null: false, default: 0
      t.integer :height, null: false, default: 0

      t.timestamps null: false
    end
  end
end
