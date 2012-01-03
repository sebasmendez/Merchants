class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :client_id
      t.string :bill_kind

      t.timestamps
    end
    add_index :orders, :client_id
  end
end
