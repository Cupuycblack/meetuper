# frozen_string_literal: true

require 'rails_helper'

describe MeetupClient do
  let(:options) { { api_key: '123123123' } }
  subject { described_class.new(options) }
  describe '#initialze' do
    it 'sets key variable to api_key option' do
      expect(subject.key).to eq '123123123'
    end
  end

  describe '#prepare' do
    let(:expected_params) do
      { query: { key: '123123123', location: 'test', page: 10, sign: true } }
    end
    it 'sets the url and params variable' do
      subject.prepare('/test', location: 'test')
      expect(subject.url).to eq '/test'
      expect(subject.params).to eq expected_params
    end
  end

  describe '#parse_response' do
    let(:response) {
      [
        {
          'name' => 'test',
          'status' => 'test_status',
          'localized_location' => 'test_location',
          'meta_category' => {
            'name' => 'category'
          },
          'key_photo' => {
            'thumb_link' => 'link'
          }
        }
      ]
    }
    let(:parsed_response) {
      [
        {
          name: 'test',
          status: 'test_status',
          location: 'test_location',
          category: 'category',
          image: 'link'
        }
      ]
    }
    it 'gets appropritate data from response' do
      expect(subject.parse_response(response)).to eq(parsed_response)
    end
  end

  describe '#execute' do
    let(:url) { 'https://api.meetup.com/find/groups' }
    let(:params) { { location: 'test' } }
    let(:result_url) { "#{url}?#{subject.params[:query].to_query}" }
    it 'should send get request' do
      subject.prepare(url, params)
      stub_request(:get, result_url).with(
        headers: {
          'Accept': '*/*',
          'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent': 'Ruby'
        }
      ).to_return(status: 200, body: '', headers: {})
      subject.execute
      expect(WebMock).to have_requested(:get, result_url)
    end
  end
end
