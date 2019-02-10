# frozen_string_literal: true

require 'rails_helper'

describe MeetupClient do
  describe '#initialze' do
    let(:options) { { api_key: '123123123' } }
    subject { described_class.new(options) }
    it 'sets key variable to api_key option' do
      expect(subject.key).to eq '123123123'
    end
  end
end
