class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills do |t|
      t.integer :barcode, :null => false
      t.date :date
      t.decimal :amount, :precision => 15, :scale => 2
      t.string :bill_kind, :null => false
      t.integer :client_id
      t.text :items, :null => false

      t.timestamps
    end
    
    add_index :bills, :barcode, :unique => true
  end

  def self.down
    drop_table :bills
  end
end
