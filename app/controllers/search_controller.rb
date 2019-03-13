class SearchController < ApplicationController
  MEETUP_GROUP_PATH = 'https://api.meetup.com/find/groups'.freeze

  def index
    @result = CacheQueryService.new(cache_params).get
  end

  def poll
    @groups = groups_data
  end

  private

  def cache_params
    {
      'key' => query_params.to_query,
      'type' => 'meetup',
      'params' => query_params.to_hash,
      'url' => MEETUP_GROUP_PATH
    }
  end

  def groups_data
    return [] if poll_params.empty? || MeetupDataService.get(poll_params[:poll_key]).nil?
    MeetupDataService.get(poll_params[:poll_key])
  end

  def poll_params
    params.permit(:poll_key)
  end

  def query_params
    params.permit(:location)
  end
end
