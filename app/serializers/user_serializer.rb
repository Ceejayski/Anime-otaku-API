class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :username, :admin
end
