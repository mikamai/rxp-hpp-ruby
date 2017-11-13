require 'utils/generator'
require 'hpp_encodable'

class HppResponse < HppEncodable
  include Generator

  FIELDS = [
    :merchant_id,
    :account,
    :order_id,
    :amount,
    :authcode,
    :timestamp,
    :sha1hash,
    :result,
    :message,
    :cvnresult,
    :pasref,
    :batchid,
    :eci,
    :cavv,
    :xid,
    :comment1,
    :comment2,
    :tss
  ]

  MAP_FIELDS = [:tss]

  attr_accessor *FIELDS

  def build_hash(secret)
    @hash = generate_hash secret
    self
  end

  def generate_hash(secret)

    hash_result = [
      @timestamp,
      @merchant_id,
      @order_id,
      @result,
      @message,
      @pasref,
      @authcode
    ].join(',')

    encode_hash hash_result, secret
  end
end
