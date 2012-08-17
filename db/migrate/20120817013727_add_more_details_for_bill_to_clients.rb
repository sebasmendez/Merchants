class AddMoreDetailsForBillToClients < ActiveRecord::Migration
  def change
    add_column :clients, :uic, :string
    add_column :clients, :uic_type, :string 
  end
end
