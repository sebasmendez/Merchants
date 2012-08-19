class AddClientKindToBill < ActiveRecord::Migration
  def change
      add_column :bills, :client_kind, :string, limit: 1
  end
end
