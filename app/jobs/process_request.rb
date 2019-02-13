class ProcessRequest
  @queue = :request

  def self.perform(options)
    client = ClientFactory.new(options['type']).create_client
    client.prepare(options['url'], options['params'])
    response = client.execute
    RedisService.set(options['key'], client.parse_response(response.to_json), ex: client.expire_time)
  end
end
