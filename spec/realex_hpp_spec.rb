# frozen_string_literal: true

require 'spec_helper'

describe RealexHpp do
  subject { described_class.new 'mysecret' }

  context 'with request' do
    let(:with_card_storage) { false }
    let(:expected_request)  { valid_hpp_request with_card_storage }

    describe '#request_to_json' do
      let!(:json) { subject.request_to_json expected_request }
      let(:converted_request) { subject.request_from_json json }

      it 'parses correct' do
        expected_request.decode
        expect(expected_request.to_json).to eq converted_request.to_json
      end
    end

    describe '#request_from_json encoded' do
      let(:json) { encoded_request.to_json }
      let(:converted_request) { subject.request_from_json json }

      it 'parses correct' do
        expect(expected_request.to_json).to eq converted_request.to_json
      end
    end

    describe '#request_from_json decoded' do
      let(:json) { valid_request.to_json }
      let(:converted_request) { subject.request_from_json json, false }

      it 'parses correct' do
        expect(expected_request.to_json).to eq converted_request.to_json
      end
    end

    describe '#request_from_json card storage' do
      let(:with_card_storage) { true }
      let(:json) { valid_request_with_card_storage.to_json }
      let(:converted_request) { subject.request_from_json json, false }

      it 'parses correct' do
        expect(expected_request.to_json).to eq converted_request.to_json
      end
    end
  end

  context 'with response' do
    let(:expected_response) { valid_hpp_response }

    describe '#response_to_json' do
      let!(:json) { subject.response_to_json expected_response }
      let(:converted_response) { subject.response_from_json json }

      it 'parses correct' do
        expected_response.decode
        expect(expected_response.to_json).to eq converted_response.to_json
      end
    end

    describe '#response_from_json encoded' do
      let(:encoded) { encoded_response }

      context 'when the response is altered' do
        let(:json) { encoded.to_json }

        %w(
          SHA1HASH
          MERCHANT_ID
          TIMESTAMP
          ORDER_ID
          RESULT
          MESSAGE
          PASREF
          AUTHCODE
        ).each do |field|
          context "when #{field} is beign altered" do
            before { encoded['MERCHANT_ID'] = 'altered!' }
            it 'raise an exception' do
              expect { subject.response_from_json json }
                .to raise_exception RealexValidationException
            end
          end
        end
      end

      context 'when the response is not altered' do
        let(:json) { encoded.to_json }
        let(:converted_response) { subject.response_from_json json }

        it 'parses correct' do
          expect(expected_response.to_json).to eq converted_response.to_json
        end
      end
    end
  end
end
