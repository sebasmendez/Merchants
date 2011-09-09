class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name,:null => false
      t.string :last_name,:null => false
      t.string :document,:null => false, :unique => true
      t.string :adress
      t.string :email
      t.string :location
      t.integer :phone
      t.string :cellphone
      t.string :client_kind,:null => false
      t.string :bill_kind
      t.decimal :amount, :scale => 2
      t.decimal :spend, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
