class JwtService
  SECRET = Rails.application.secret_key_base

  def self.encode(payload)
    JWT.encode(payload, SECRET, 'HS256')
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET, true, { algorithm: 'HS256' })
    decoded.first.with_indifferent_access
  rescue JWT::DecodeError => e
    Rails.logger.error "JWT Decode Error: #{e.message}"
    nil
  end
end