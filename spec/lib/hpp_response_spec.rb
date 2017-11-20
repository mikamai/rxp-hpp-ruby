# frozen_string_literal: true

require 'spec_helper'

describe HppResponse do
  subject { valid_hpp_response }

  describe '#valid_hash?' do
    before { subject.sha1hash = subject.generate_hash 'mysecret' }
    %i[timestamp merchant_id order_id result message pasref authcode].each do |field|
      context "when #{field} change" do
        before { subject.send "#{field}=", 'new value' }
        it { expect(subject.valid_hash?('mysecret')).to be_falsey }
      end
    end
    context 'when no relevant field change' do
      before { subject.cavv = 'new value' }
      it { expect(subject.valid_hash?('mysecret')).to be_truthy }
    end
  end
end
