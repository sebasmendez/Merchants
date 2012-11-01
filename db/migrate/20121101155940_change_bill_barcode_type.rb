class ChangeBillBarcodeType < ActiveRecord::Migration
  def up
    change_column :bills, :barcode, :integer, limit: 8
  end

  def down
    change_column :bills, :barcode, :integer
  end
end
