class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :price
      t.integer :number_of_stocks
      t.integer :institution_id

      t.timestamp null:false
    end
  end
end
