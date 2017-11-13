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
        expect(request1.build_hash('mysecret').hash).to eq "2d444b908323033af25752a1d5eb91e0ba724374"
      end
    end

    it 'produce always the same hash' do
      expect(request1.build_hash('mysecret').hash).to eq "8e56469e62505a25731d809b1eef6c564aea7ec4"
    end
  end
end
