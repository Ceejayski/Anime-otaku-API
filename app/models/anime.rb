class Anime < ApplicationRecord
  extend FriendlyId
  # validations
  validates_presence_of :name, :description, :slug, :rating
  validates :rating, numericality: { less_than_or_equal_to: 5 }
  # association
  has_many :favourites, dependent: :destroy
  # scopes
  scope :highest_rated, -> { order(rating: :desc) }

  friendly_id :name, use: %i[finders slugged]
  belongs_to :user
  mount_uploader :header_image, HeaderImageUploader
end
