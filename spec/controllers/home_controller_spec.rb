# frozen_string_literal: true

require 'rails_helper'

describe HomeController do
  describe 'GET index' do
    it {
      get :index
      assert_response :success
    }
  end
end
