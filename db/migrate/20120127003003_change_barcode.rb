class ChangeBarcode < ActiveRecord::Migration
  def change
    change_column :products, :barcode, :string
  end

end
