class ChangeAdressToAddress < ActiveRecord::Migration
  def change
    rename_column :clients, :adress, :address
  end

end
