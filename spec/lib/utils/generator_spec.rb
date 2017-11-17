# frozen_string_literal: true

require 'spec_helper'

describe Generator do
  subject { Object.new.extend Generator }

  describe '.encode_hash' do
    let(:test)     { '20120926112654.thestore.ORD453-11.00.Successful.3737468273643.79347' }
    let(:secret) { 'mysecret' }
    let(:expected) { '368df010076481d47a21e777871012b62b976339' }

    it { expect(subject.encode_hash(test, secret)).to eq expected }
  end

  describe '.generate_timestamp' do
    it { expect(subject.generate_timestamp).to match /[0-9]{13}/ }
  end

  describe '.generate_order_id' do
    it { expect(subject.generate_order_id).to_not be_nil }
  end
end
