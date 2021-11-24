class User < ApplicationRecord
  # validations
  validates_presence_of :username, :password_digest, :email
  validates_uniqueness_of :username, case_sensitive: true
  validates_uniqueness_of :email, case_sensitive: true
  # associations
  has_secure_password
  has_many :animes, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favorite_anime, through: :favourites, source: :anime
end
