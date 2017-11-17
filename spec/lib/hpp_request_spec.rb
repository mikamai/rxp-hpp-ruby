# frozen_string_literal: true

require 'spec_helper'

describe HppRequest do
  let(:with_card_storage) { false }
  subject { valid_hpp_request with_card_storage }

  describe '#encode' do
    it { expect { subject.encode }.to change(subject, :amount) }
  end

  describe '#encode' do
    it { expect { subject.decode }.to change(subject, :amount) }
  end

  describe '#hash' do
    context 'with hpp_select_stored_card' do
      let(:request2) { valid_hpp_request }

      before do
        subject.payer_ref = 'newpayer1'
        request2.payer_ref = 'newpayer1'
        request2.hpp_select_stored_card = 'HPP_SELECT_STORED_CARD'
      end

      it 'overrides payer_ref' do
        expect(subject.build_hash('mysecret').hash).to_not eq request2.build_hash('mysecret').hash
      end
    end

    context 'with payer_ref and pmt_ref' do
      let!(:with_card_storage) { true }

      before do
        subject.timestamp   = '20130814122239'
        subject.merchant_id = 'thestore'
        subject.order_id    = 'ORD453-11'
        subject.amount      = '29900'
        subject.currency    = 'EUR'
        subject.payer_ref   = 'newpayer1'
        subject.pmt_ref     = 'mycard1'
      end

      it 'generates the correct hash' do
        expect(subject.build_hash('mysecret').hash).to eq '4106afc4666c6145b623089b1ad4098846badba2'
      end
    end

    context 'without hpp_select_stored_card' do
      let(:request2) { valid_hpp_request }

      before do
        subject.payer_ref = 'newpayer1'
        request2.hpp_select_stored_card = ''
      end

      it 'overrides payer_reference' do
        expect(subject.build_hash('mysecret').hash).to eq request2.build_hash('mysecret').hash
      end
    end

    context 'with hpp_fraud_filter_mode' do
      before do
        subject.timestamp             = '20130814122239'
        subject.merchant_id           = 'thestore'
        subject.order_id              = 'ORD453-11'
        subject.amount                = '29900'
        subject.currency              = 'EUR'
        subject.hpp_fraud_filter_mode = 'ACTIVE'
      end

      it 'produce a different hash' do
        expect(subject.build_hash('mysecret').hash).to eq 'b7b3cbb60129a1c169a066afa09ce7cc843ff1c1'
      end
    end

    context 'with the same values' do
      before do
        subject.timestamp   = '20130814122239'
        subject.merchant_id = 'thestore'
        subject.order_id    = 'ORD453-11'
        subject.amount      = '29900'
        subject.currency    = 'EUR'
      end

      it 'produce always the same hash' do
        expect(subject.build_hash('mysecret').hash).to eq 'cc72c08e529b3bc153481eda9533b815cef29de3'
      end
    end
  end
end
