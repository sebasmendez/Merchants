class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.integer :day
      t.integer :month
      t.integer :year
      t.integer :count, default: 0
      t.decimal :total, precision: 15, scale: 2, default: 0

      t.timestamps
    end
  end
end
