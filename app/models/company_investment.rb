class CompanyInvestment < ActiveRecord::Base
  has_many :investments
  has_many :stocks
  belongs_to :user

end
