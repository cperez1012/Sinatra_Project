class Investment < ActiveRecord::Base
  belongs_to :user_id
  belongs_to :institution_id

end
