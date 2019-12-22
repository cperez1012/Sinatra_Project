class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.integer :user_id
      t.integer :institution_id

      t.timestamp null:false
    end
  end
end
