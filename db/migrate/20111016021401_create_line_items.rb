class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :product_id
      t.integer :cart_id
      t.integer :order_id
      t.decimal :price, :precision => 15, :scale => 2, default: 0.00
      t.decimal :quantity,:precision => 15, :scale => 2, default: 1

      t.timestamps
    end
  end
end
