class AddPriceToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :price, :decimal, precision: 15, scale: 2
  end
end
