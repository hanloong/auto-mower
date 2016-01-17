class CreateMowers < ActiveRecord::Migration
  def change
    create_table :mowers do |t|
      t.integer :x, null: false, default: 0
      t.integer :y, null: false, default: 0
      t.string :heading
      t.string :commands
      t.belongs_to :lawn, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
