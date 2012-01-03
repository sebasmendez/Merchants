class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :barcode, null: false
      t.string :name, :null => false
      t.string :mark
      t.string :fragance
      t.decimal :price, :null => false, :precision => 15, :scale => 2
      t.decimal :count,:null => false, :precision => 15, :scale => 2
      t.string :uni
      t.decimal :stock, default: 0.0
      t.decimal :pricedist
      t.decimal :iva
      t.integer :category_id

      t.timestamps
    end
    
    add_index :products, :barcode, :unique => true
    add_index :products, :name
  end

  def self.down
    drop_table :products
  end
end
