class AddPricedistToProducts < ActiveRecord::Migration
  def change
    add_column :products, :pricedist, :decimal
  end
end
