class CreateCompanyInvestment < ActiveRecord::Migration
  def change
    create_table :company_investments do |t|
      t.string :name
      t.text :description
      t.integer :year_founded
      t.string :industry
      t.string :imaage_url

      t.timestamp null:false
    end
  end
end
