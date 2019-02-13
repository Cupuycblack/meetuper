# frozen_string_literal: true

require 'rails_helper'

describe SearchController, :type => :request do
  describe 'GET index' do
    context 'when data is cached' do
      before do
        $redis.set('location=key', '[]')
      end
      it {
        get '/meetups', xhr: true, params: { location: 'key' }
        expect(response).to render_template(:index)
        assert_response :success
      }
    end
    context 'when data is not cached' do
      it {
        get '/meetups', xhr: true, params: { location: 'key' }
        expect(JSON.parse(response.body)).to eq('key' => 'location=key', 'async' => true)
        assert_response :success
      }
    end
  end

  describe 'GET poll' do
    it {
      get '/poll', xhr: true
      assert_response :success
      expect(response).to render_template(:poll)
    }
  end
end
