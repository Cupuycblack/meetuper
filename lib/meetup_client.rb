class MeetupClient
  include HTTParty

  base_uri 'https://api.meetup.com'

  attr_reader :key
  def initialize(options = {})
    @key = options[:api_key]
  end

  def groups(params)
    self.class.get(groups_url, query_params(params))
  end

  def groups_url
    '/find/groups'
  end

  def query_params(params)
    query = { key: key, sign: true, page: 10 }.merge(params)
    { query: query }
  end
end
