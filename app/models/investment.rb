class Investment < ActiveRecord::Base
  belongs_to :user_id
  belongs_to :company_id

end
