class UpgradesInProducts < ActiveRecord::Migration
  def change
    change_column :products, :iva, :decimal, precision: 15, scale: 2, default: 21
    change_column :products, :stock, :decimal, precision: 15, scale: 2, default: 0
    change_column :products, :price, :decimal, precision: 15, scale: 2
    change_column :products, :count, :decimal, precision: 15, scale: 2
    change_column :products, :pricedist, :decimal, precision: 15, scale: 2
    
    add_column :products, :earn, :decimal, precision: 15, scale: 2, default: 30
  end
end
