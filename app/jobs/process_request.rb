class ProcessRequest
  @queue = :request

  def self.perform(options)
    client = ClientFactory.new(options['type']).create_client
    client.prepare(options['url'], options['params'])
    response = client.execute
    parsed_response = client.parse_response(response).to_json
    MeetupDataService.set(options['key'], parsed_response, ex: client.expire_time)
    parsed_response
  end
end
