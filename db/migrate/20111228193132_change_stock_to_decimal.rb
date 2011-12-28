class ChangeStockToDecimal < ActiveRecord::Migration
  def change
    change_column :products, :stock, :decimal, default: 0
  end

end
