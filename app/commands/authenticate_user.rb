class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    return unless user

    { auth_token: JsonWebToken.encode(user_id: user.id), username: user.username, admin: user.admin,
      message: 'Logged in Successfully' }
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email)
    return user if user&.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
