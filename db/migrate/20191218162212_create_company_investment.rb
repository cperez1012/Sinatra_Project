class CreateCompanyInvestment < ActiveRecord::Migration
  def change
    create_table :company_investments do |t|
      t.string :name
      t.text :description
      t.integer :year_founded
      t.string :industry
      t.string :image_url
      t.integer :user_id

      t.timestamp null:false
    end
  end
end
