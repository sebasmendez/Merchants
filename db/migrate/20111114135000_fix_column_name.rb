class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :orders, :document, :client_id
  end

  def down
  end
end
