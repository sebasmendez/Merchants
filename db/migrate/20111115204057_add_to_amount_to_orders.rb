class AddToAmountToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :to_amount, :boolean, default: false
  end
end
