class ChangeQuantity < ActiveRecord::Migration
  def change
    change_column :line_items, :quantity, :decimal, default: 1
    
  end

  
end
