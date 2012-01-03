class AddStockToProducts < ActiveRecord::Migration
  def change
    add_column :products, :stock, :decimal, default: 0
  end
end
