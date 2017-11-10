require 'spec_helper'

describe RealexHpp do
  subject { described_class.new 'mysecret' }

  describe '#request_to_json' do
    let(:expected_request) { sample_valid }
    let!(:json) { subject.request_to_json expected_request }
    let(:converted_request) { subject.request_from_json json }

    it 'parses correct json' do
      expected_request.decode
      expect(expected_request.to_json).to eq converted_request.to_json
    end
  end
end
