# frozen_string_literal: true

require 'rails_helper'

describe SearchController, :type => :request do
  describe 'GET index' do
    before do
      $redis.set('location=key', '[]')
    end
    it {
      get '/', params: { location: 'key' }
      expect(response).to render_template(:index)
      assert_response :success
    }
  end

  describe 'GET poll' do
    it {
      get '/poll', xhr: true
      assert_response :success
      expect(response).to render_template(:poll)
    }
  end
end
