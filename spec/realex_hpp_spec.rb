require 'spec_helper'

describe RealexHpp do
  subject { described_class.new 'mysecret' }

  describe '#request_to_json' do
    let(:expected_request) { sample_valid }
    let!(:json) { subject.request_to_json expected_request }
    let(:converted_request) { subject.request_from_json json }

    it 'parses correct' do
      expected_request.decode
      expect(expected_request.to_json).to eq converted_request.to_json
    end
  end

  describe '#request_from_json encoded' do
    let(:expected_request) { sample_valid }
    let!(:json) { encoded_json }
    let(:converted_request) { subject.request_from_json json }

    it 'parses correct' do
      expect(expected_request.to_json).to eq converted_request.to_json
    end
  end

  describe '#request_from_json dencoded' do
    pending 'to implement'
  end

  describe '#request_from_json card storage' do
    pending 'to implement'
  end

  describe '#response_to_json' do
    pending 'to implement'
  end

  describe '#response_from_json encoded' do
    pending 'to implement'
  end

  describe '#response_from_json decoded' do
    pending 'to implement'
  end
end
