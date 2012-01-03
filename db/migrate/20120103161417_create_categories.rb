class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :categoria

      t.timestamps
    end
    add_index :categories, :categoria, :unique => true
  end
end
