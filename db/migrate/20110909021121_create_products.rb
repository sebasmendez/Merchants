class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :barcode, :unique => true
      t.string :name, :null => false
      t.string :mark
      t.string :fragance
      t.decimal :price, :null => false
      t.decimal :count,:null => false, :scale => 2
      t.string :uni

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
