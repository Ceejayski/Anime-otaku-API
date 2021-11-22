class AnimeSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :rating, :header_image
end
