class AddOrderIdToBill < ActiveRecord::Migration
  def change
    add_column :bills, :order_id, :integer
  end
end
