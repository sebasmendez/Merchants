class ArreglarDecimalesProductos < ActiveRecord::Migration
  def change
	change_column :products, :iva, :decimal, precision: 15, scale: 2
	change_column :products, :pricedist, :decimal, precision: 15, scale: 2
	change_column :products, :stock, :decimal, precision: 15, scale: 2
  end
end
