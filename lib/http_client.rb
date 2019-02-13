class HttpClient
  include HTTParty

  attr_reader :key, :response
  attr_accessor :params, :url

  def initialize(options = {})
    @key = options[:api_key]
    @response = nil
  end

  def prepare(url, params)
    @params = query_params(params)
    @url = url
    self
  end

  def execute
    @response = self.class.get(url, params)
  end

  private

  def query_params(params)
    params
  end
end
