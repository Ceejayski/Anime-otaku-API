class FavouriteSerializer
  include JSONAPI::Serializer
  attributes :user_id, :anime_id
end
