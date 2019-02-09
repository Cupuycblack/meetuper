# frozen_string_literal: true

redis_config = YAML.load_file(Rails.root.join('config/redis.yml'))[Rails.env]
$redis = Redis.new(
  host: redis_config['host'],
  port: redis_config['port'],
  password: redis_config['password'],
  thread_safe: true
)
