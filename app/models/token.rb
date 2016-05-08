class Token
  TTL = 10.minutes

  attr_accessor :token

  def initialize(credit_card)
    @credit_card = credit_card
    build
  end

  def store
    # TODO Use real data.
    redis.set 'test', 'dummy-data'
  end

  def build
    expire_at = DateTime.now + TTL
    payload = {
      bin: @credit_card.bin,
      last_four: @credit_card.last_four,
      exp: expire_at
    }
    @token = encode payload
  end

  private

    def redis
      Redis.current
    end

    def encode(data)
      key = Rails.application.secrets.jwt_key
      JWT.encode data, key, 'HS256'
    end
end
