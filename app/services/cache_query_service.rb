class CacheQueryService
  attr_reader :options

  def initialize(options)
    @options = options
  end

  def get
    unless MeetupDataService.get(options['key']).nil?
      return {
        cached: true,
        results: MeetupDataService.get(options['key'])
      }
    end
    send_request
  end

  private

  def async?
    true
  end

  def send_request
    if async?
      perform_async_request
    else
      perform_request
    end
  end

  def perform_async_request
    Resque.enqueue(ProcessRequest, options)
    { async: true, key: options['key'] }
  end

  def perform_request
    response = ProcessRequest.perform(options)
    { async: false, results: JSON.parse(response) }
  end
end
