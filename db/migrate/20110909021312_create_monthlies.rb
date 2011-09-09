class CreateMonthlies < ActiveRecord::Migration
  def self.up
    create_table :monthlies do |t|
      t.integer :month
      t.integer :year
      t.decimal :sold, :scale => 2
      t.decimal :bought, :scale => 2
      t.decimal :to_pay, :scale => 2
      t.boolean :paid

      t.timestamps
    end
  end

  def self.down
    drop_table :monthlies
  end
end
