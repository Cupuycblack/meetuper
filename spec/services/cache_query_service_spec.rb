# frozen_string_literal: true

require 'rails_helper'

describe CacheQueryService do
  let(:options) do
    { 'type' => 'meetup', 'url' => 'https://test.com',
      'params' => { 'location' => 'test' }, 'key' => 'test' }
  end
  describe '#get' do
    subject { described_class.new(options).get }
    context 'when request is cached' do
      before do
        $redis.set('test', '[]')
      end
      it 'returns cached data' do
        expect(subject).to eq(cached: true, results: [])
      end
    end

    context 'when async set to false' do
      before do
        allow_any_instance_of(CacheQueryService).to receive(:async?).and_return(false)
        allow_any_instance_of(MeetupClient).to receive(:execute).and_return('[]')
        allow_any_instance_of(MeetupClient).to receive(:parse_response).and_return('[]')
      end
      it 'returns cached data' do
        expect(subject).to eq(async: false, results: '[]')
      end
    end

    context 'when async set to true' do
      before do
        allow_any_instance_of(CacheQueryService).to receive(:async?).and_return(true)
      end
      it 'triggers background job' do
        subject
        expect(ProcessRequest).to have_queued(options)
      end
      it 'returns key' do
        expect(subject).to eq(key: 'test', async: true)
      end
    end
  end
end
