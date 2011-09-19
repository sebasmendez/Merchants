class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :barcode
      t.string :name, :null => false
      t.string :mark
      t.string :fragance
      t.decimal :price, :null => false, :precision => 15, :scale => 2
      t.decimal :count,:null => false, :precision => 15, :scale => 2
      t.string :uni

      t.timestamps
    end
    
    add_index :products, :barcode, :unique => true
  end

  def self.down
    drop_table :products
  end
end
