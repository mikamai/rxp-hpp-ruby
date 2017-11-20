# frozen_string_literal: true

require 'utils/generator'
require 'hpp_encodable'
require 'base64'
require 'json'

# HppRequest creates an Hpp request and produce the seed to initialize
# the Hpp comunication
class HppRequest < HppEncodable
  include Generator

  FIELDS = %i(
    merchant_id
    account
    order_id
    amount
    currency
    timestamp
    sha1hash
    auto_settle_flag
    comment1
    comment2
    return_tss
    shipping_code
    shipping_co
    billing_code
    billing_co
    cust_num
    var_ref
    prod_id
    hpp_lang
    card_payment_button
    card_storage_enable
    offer_save_card
    payer_ref
    pmt_ref
    payer_exist
    validate_card_only
    dcc_enable
    hpp_fraud_filter_mode
    hpp_select_stored_card
  ).freeze

  JSON_IGNORE = JSON_IGNORE + %i(
    @hpp_fraud_filter_mode
    @hpp_select_stored_card
    @payer_ref
  )

  attr_accessor(*FIELDS)

  def build_hash(secret)
    generate_defaults

    if @hpp_select_stored_card && !@hpp_select_stored_card != ''
      @payer_ref = @hpp_select_stored_card
    end

    hash_seed = default_seed
    hash_seed = add_payer_ref_and_pmt_ref hash_seed
    hash_seed = add_fraud_filter_mode hash_seed

    @sha1hash = encode_hash hash_seed, secret
    self
  end

  private

  def add_payer_ref_and_pmt_ref(hash_seed)
    if @card_storage_enable == '1' ||
       (
         @hpp_select_stored_card && !@hpp_select_stored_card.empty?
       )
      "#{hash_seed}.#{[@payer_ref || '', @pmt_ref || ''].join('.')}"
    else
      hash_seed
    end
  end

  def add_fraud_filter_mode(hash_seed)
    if @hpp_fraud_filter_mode && @hpp_fraud_filter_mode != ''
      "#{hash_seed}.#{@hpp_fraud_filter_mode}"
    else
      hash_seed
    end
  end

  def default_seed
    [
      @timestamp,
      @merchant_id,
      @order_id,
      @amount,
      @currency
    ].map { |value| value_or_empty value }.join '.'
  end

  def generate_defaults
    @timestamp = generate_timestamp if @timestamp.nil? || @timestamp == ''
    @order_id  = generate_order_id  if @order_id.nil?  || @order_id == ''
  end
end
