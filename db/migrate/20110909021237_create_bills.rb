class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills do |t|
      t.integer :barcode, :unique => true
      t.date :date
      t.decimal :amount, :scale => 2
      t.string :bill_kind
      t.integer :client_id
      t.text :items

      t.timestamps
    end
  end

  def self.down
    drop_table :bills
  end
end
