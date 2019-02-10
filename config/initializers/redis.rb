# frozen_string_literal: true

$redis = Redis.new(
  host: Settings.redis[:host],
  port: Settings.redis[:port],
  password: Settings.redis[:password],
  thread_safe: true
)
