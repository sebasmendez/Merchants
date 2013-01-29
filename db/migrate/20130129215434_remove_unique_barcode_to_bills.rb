class RemoveUniqueBarcodeToBills < ActiveRecord::Migration
  def up
    remove_index :bills, :barcode # To remove unique
    add_index :bills, :barcode
  end

  def down
    remove_index :bills, :barcode
    add_index :bills, :barcode, unique: true
  end
end
