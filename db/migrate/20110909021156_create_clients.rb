class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name,:null => false
      t.string :last_name,:null => false
      t.string :document,:null => false
      t.string :adress
      t.string :email
      t.string :location
      t.integer :phone
      t.string :cellphone
      t.string :client_kind,:null => false
      t.string :bill_kind
      t.decimal :amount, :precision => 15, :scale => 2, default: 0.00
      t.decimal :spend, :precision => 15, :scale => 2, default: 0.00

      t.timestamps
    end
    
    add_index :clients, :document, :unique => true
    add_index :clients, :last_name
  end

  def self.down
    drop_table :clients
  end
end
