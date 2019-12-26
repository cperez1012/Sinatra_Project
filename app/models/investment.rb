require_relative "./concerns/slugifiable.rb"

class Investment < ActiveRecord::Base

  belongs_to :user_id
  belongs_to :institution_id

  validates :user_id, presence: true

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
