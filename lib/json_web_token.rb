class JsonWebToken
  class << self
    SECRET = 'anime-otaku-out-for-blood-&-$'.freeze
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET, 'HS256')
    end

    def decode(token)
      body = JWT.decode(token, SECRET, true, { algorithm: 'HS256' })[0]
      HashWithIndifferentAccess.new body
    rescue StandardError
      nil
    end
  end
end
