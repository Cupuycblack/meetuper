module MeetupDataService
  class << self
    def set(key, value, options)
      redis.set(key, value, options)
    end

    def get(key)
      res = redis.get(key)
      return nil unless res
      JSON.parse(res)
    end

    private

    def redis
      $redis
    end
  end
end
