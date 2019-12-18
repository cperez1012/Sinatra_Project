class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :price

      t.timestamp null:false
    end
  end
end
