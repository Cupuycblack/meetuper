# frozen_string_literal: true

require 'rails_helper'

describe MeetupDataService do
  subject { described_class }
  describe '#set' do
    let(:key) { 'test' }
    let(:value) { 'test_value' }
    it 'puts data to redis' do
      subject.set(key, value)
      expect($redis.get('key')).to value
    end
  end

  describe '#get' do
    let(:key) { 'test' }
    let(:value) { 'test_value' }
    it 'puts data to redis' do
      $redis.set(key, value)
      expect(subject.get(key)).to value
    end
  end
end
