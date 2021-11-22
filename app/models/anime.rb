class Anime < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[finders slugged]
  belongs_to :user
  # validations
  validates_presence_of :name, :description, :slug, :header_image
  mount_uploader :Header_image, HeaderImageUploader
end
