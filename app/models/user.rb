class User < ApplicationRecord
  # validations
  validates_presence_of :username, :password_digest, :email
  validates_uniqueness_of :username, :email

  has_secure_password
  has_many :animes, dependent: :destroy
end
