class AddIvaToProducts < ActiveRecord::Migration
  def change
    add_column :products, :iva, :decimal
  end
end
