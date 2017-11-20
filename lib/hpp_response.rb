# frozen_string_literal: true

require 'utils/generator'
require 'hpp_encodable'

# HppResponse decodes response from realex hpp
class HppResponse < HppEncodable
  include Generator

  FIELDS = %i(
    merchant_id
    account
    order_id
    amount
    authcode
    timestamp
    sha1hash
    result
    message
    cvnresult
    pasref
    batchid
    eci
    cavv
    xid
    comment1
    comment2
    tss
  ).freeze

  MAP_FIELDS = [:tss].freeze

  attr_accessor(*FIELDS)

  def build_hash(secret)
    @sha1hash = generate_hash secret
    self
  end

  def generate_hash(secret)
    hash_seed = [
      @timestamp,
      @merchant_id,
      @order_id,
      @result,
      @message,
      @pasref,
      @authcode
    ].map { |value| value_or_empty value }.join '.'

    encode_hash hash_seed, secret
  end

  def valid_hash?(secret)
    generate_hash(secret) == @sha1hash
  end
end
