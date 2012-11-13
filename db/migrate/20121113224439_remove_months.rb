class RemoveMonths < ActiveRecord::Migration
  def change
    drop_table :monthlies
  end
end
