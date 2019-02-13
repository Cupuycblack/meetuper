module RedisService
  class << self
    def set(key, value, options)
      redis.set(key, value, options)
    end

    def get(key)
      redis.get(key)
    end

    private

    def redis
      $redis
    end
  end
end
