require 'spec_helper'

describe HppRequest do
  subject do
    request = described_class.new
    request.amount = 5
    request
  end

  describe '#encode' do
    it { expect { subject.encode }.to change(subject, :amount) }
  end

  describe '#encode' do
    it { expect { subject.decode }.to change(subject, :amount) }
  end

  describe '#hash' do
    let(:request1) { valid_hpp_request }

    context 'with hpp_select_stored_card' do
      let(:request2) { valid_hpp_request }

      before do
        request1.payer_reference = 'PAYER_REFERENCE'
        request2.payer_reference = 'PAYER_REFERENCE'
        request2.hpp_select_stored_card = 'HPP_SELECT_STORED_CARD'
      end

      it 'overrides payer_reference' do
        expect(request1.build_hash('mysecret').hash).to_not eq(request2.build_hash('mysecret').hash)
      end
    end

    context 'without hpp_select_stored_card' do
      let(:request2) { valid_hpp_request }

      before do
        request1.payer_reference = 'PAYER_REFERENCE'
        request2.payer_reference = 'PAYER_REFERENCE'
        request2.hpp_select_stored_card = ''
      end

      it 'overrides payer_reference' do
        expect(request1.build_hash('mysecret').hash).to eq(request2.build_hash('mysecret').hash)
      end
    end

    context 'with hpp_fraud_filter_mode' do
      before { request1.hpp_fraud_filter_mode = 'FRAUD_FILTER_MODE_ACTIVE' }

      it 'produce a different hash' do
        expect(request1.build_hash('mysecret').hash).to eq "236cb296d1ad94a4547602a070993c05f812c58f"
      end
    end

    it 'produce always the same hash' do
      expect(request1.build_hash('mysecret').hash).to eq "aafab12dd4f92e0d6e13dd8c3fce93232aedf28a"
    end
  end
end
