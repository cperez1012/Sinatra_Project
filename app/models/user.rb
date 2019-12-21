class User < ActiveRecord::Base
  has_many :investments
  has_many :companys
  has_many :stocks, through: :companys

  has_secure_password

  validates_presence_of  :username, :email, :password_digest
  validates_uniqueness_of :username, presence: {message: "That username is already taken, please use another username."}
  validates_uniqueness_of :email, presence: {message: "That email is already associated to another account. Please use another email."}

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.detect {|user| user.username.downcase.gsub(" ", "-") == slug}
  end
end
