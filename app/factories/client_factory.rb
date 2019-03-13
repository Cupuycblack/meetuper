class ClientFactory
  attr_reader :type
  def initialize(type)
    @type = type
  end

  def create_client
    case type
    when 'meetup'
      MeetupClient.new(api_key: Settings.meetup_api_key)
    else
      raise "Unknown client type: #{type}"
    end
  end
end
