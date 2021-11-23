class AnimeSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :rating, :header_image, :genre_list
  attributes :related_animes do |object|
    object.find_related_genres.map { |x| x.slice(:name, :description, :rating, :genre_list, :header_image) }
      .sort_by { |hsh| hsh[:rating] }.reverse
  end
  attributes :favorite_count do |obj|
    obj.favourites.size
  end
end
