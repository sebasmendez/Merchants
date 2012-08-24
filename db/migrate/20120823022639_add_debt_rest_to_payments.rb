class AddDebtRestToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :debt_rest, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
