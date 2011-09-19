class CreateMonthlies < ActiveRecord::Migration
  def self.up
    create_table :monthlies do |t|
      t.integer :month
      t.integer :year
      t.decimal :sold, :precision => 15, :scale => 2
      t.decimal :bought, :precision => 15, :scale => 2
      t.decimal :to_pay, :precision => 15, :scale => 2
      t.boolean :paid, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :monthlies
  end
end
