class MeetupClient < HttpClient
  def expire_time
    300
  end

  def parse_response(response)
    response.map do |group|
      {
        name: group['name'],
        status: group['status'],
        location: group['localized_location'],
        category: group.dig('meta_category', 'name'),
        image: group.dig('key_photo', 'thumb_link')
      }
    end
  end

  private

  def query_params(params)
    query = { key: key, sign: true, page: 10 }.merge(params)
    { query: query }
  end

end
