require 'utils/generator'
require 'hpp_encodable'
require 'base64'
require 'json'

class HppRequest < HppEncodable
  include Generator

  FIELDS = [
    :merchant_id,
    :account,
    :order_id,
    :amount,
    :currency,
    :timestamp,
    :sha1hash,
    :auto_settle_flag,
    :comment1,
    :comment2,
    :return_tss,
    :shipping_code,
    :shipping_co,
    :billing_code,
    :billing_co,
    :cust_num,
    :var_ref,
    :prod_id,
    :hpp_lang,
    :card_payment_button,
    :card_storage_enable,
    :offer_save_card,
    :payer_ref,
    :pmt_ref,
    :payer_exist,
    :validate_card_only,
    :dcc_enable,
    :hpp_fraud_filter_mode,
    :hash,
    :hpp_select_stored_card
  ]

  JSON_IGNORE = JSON_IGNORE.concat [
    :@hpp_fraud_filter_mode,
    :@hpp_select_stored_card,
    :@payer_ref
  ]

  attr_accessor *FIELDS

  def build_hash(secret)
    @timestamp = generate_timestamp if @timestamp.nil? || @timestamp == ''
    @order_id  = generate_order_id  if @order_id.nil?  || @order_id == ''

    result_hash = ""

    if @hpp_select_stored_card && !@hpp_select_stored_card != ''
      @payer_ref = @hpp_select_stored_card
    end

    hash_seed = default_seed

    if @card_storage_enable == '1' || (@hpp_select_stored_card && !@hpp_select_stored_card.empty?)
      hash_seed = "#{hash_seed}.#{[@payer_ref || '', @pmt_ref || ''].join('.')}"
    end

    if @hpp_fraud_filter_mode && @hpp_fraud_filter_mode != ''
      hash_seed = "#{hash_seed}.#{@hpp_fraud_filter_mode}"
    end

    @hash = encode_hash hash_seed, secret
    self
  end

  private

  def default_seed
    [
      @timestamp,
      @merchant_id || '',
      @order_id,
      @amount      || '',
      @currency    || ''
    ].join '.'
  end
end
