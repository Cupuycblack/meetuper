class CacheQueryService
  attr_reader :options

  def initialize(options)
    @options = options
  end

  def get
    unless RedisService.get(options[:key]).nil?
      return {
        cached: true,
        results: JSON.parse(RedisService.get(options[:key]))
      }
    end
    send_request
  end

  private

  def send_request
    if options[:async]
      perform_async_request
    else
      perform_request
    end
  end

  def perform_async_request
    Resque.enqueue(
      ProcessRequest,
      key: options[:key],
      type: options[:type],
      url: options[:url],
      params: options[:params]
    )
    { async: true, key: options[:key] }
  end

  def perform_request
    client = ClientFactory.new(options[:type]).create_client
    client.prepare(options[:url], options[:params])
    response = client.execute
    RedisService.set(options[:key], client.parse_response(response.to_json), ex: client.expire_time)
    { async: false, results: JSON.parse(response.to_json) }
  end
end
