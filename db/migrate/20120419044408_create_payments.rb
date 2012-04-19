class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :client_id, null: false
      t.decimal :deposit, precision: 15, scale: 2

      t.timestamps
    end
  end
end
