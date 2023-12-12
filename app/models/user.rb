class User <ApplicationRecord 
  has_secure_password

  validates_confirmation_of :password
  validates_presence_of :email, :name, :password 
  validates_uniqueness_of :email

  has_many :viewing_parties
end 