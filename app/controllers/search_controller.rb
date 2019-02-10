class SearchController < ApplicationController
  def index; end
  def index
    @groups = meetup_client.groups(query_params)
  end

  private

  def meetup_client
    MeetupClient.new(api_key: Settings.meetup_api_key)
  end

  def query_params
    params.permit(:location)
  end
end
