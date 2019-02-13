# frozen_string_literal: true

require 'rails_helper'

describe ClientFactory do
  subject { described_class.new(type) }
  let(:type) { 'meetup' }

  describe '#initialize' do
    it 'assigns type attribute' do
      expect(subject.type).to eq type
    end
  end

  describe '#create_client' do
    subject { described_class.new(type).create_client}
    it 'creates client based on provided type' do
      expect(subject.class).to eq MeetupClient
    end

    context 'when type is not in the list' do
      let(:type) { 'google' }
      it 'raises an exception' do
        expect { subject }.to raise_exception(RuntimeError)
      end
    end
  end
end
