class User < ApplicationRecord
  has_many :token
  
 	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	before_save { email.downcase! }
	has_secure_password
	validates :name,  presence: true, length: { maximum: 50 }
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: true
    validates :password_digest, presence: true, length: { minimum: 6 }

end
