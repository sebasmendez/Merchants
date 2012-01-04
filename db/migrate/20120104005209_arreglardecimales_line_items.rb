class ArreglardecimalesLineItems < ActiveRecord::Migration
  def change
    change_column :line_items, :price, :decimal, precision: 15, scale: 2
    change_column :line_items, :quantity, :decimal, precision: 15, scale: 2
  end

end
