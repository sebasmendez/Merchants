class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :document
      t.string :bill_kind

      t.timestamps
    end
  end
end
