require 'resque'
require 'resque/server'

Resque.redis = $redis
Resque.redis.namespace = Rails.env.test? ? 'resque:meetuper:test' : 'resque:meetuper'

Resque.logger = Logger.new(Rails.root.join('log', 'resque.log'))
