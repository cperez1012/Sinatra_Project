class Investments < ActiveRecord::Migration
  def change
    create_table :investment do |t|
      t.integer :user_id
      t.integer :company_id

      t.timestamp null:false
    end
  end
end
