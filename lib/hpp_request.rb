require 'utils/generator'
require 'hpp_encodable'

class HppRequest < HppEncodable
  include Generator

  require 'base64'
  require 'json'

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
    :payer_reference,
    :hpp_fraud_filter_mode,
    :hash,
    :hpp_select_stored_card
  ]

  JSON_IGNORE = JSON_IGNORE.concat [
    :@hpp_fraud_filter_mode,
    :@hpp_select_stored_card,
    :@payer_reference
  ]

  attr_accessor *FIELDS

  def build_hash(secret)
    result_hash = ""

    if @hpp_select_stored_card != nil && "" != @hpp_select_stored_card
      @payer_reference = @hpp_select_stored_card
    end

    if @card_storage_enable == "1" || (@hpp_select_stored_card != nil && !@hpp_select_stored_card.empty?)
      result_hash = "#{result_hash}#{[@timestamp, ".", @merchant_id, ".", @order_id , @amount, @currency, @payerReference, @paymentReference].compact.join('.')}"

      if @hpp_fraud_filter_mode && @hpp_fraud_filter_mode != ''
        result_hash + "#{result_hash}.#{@hpp_fraud_filter_mode}"
      end

    else
      result_hash = "#{result_hash}#{[@timestamp, @merchant_id, @order_id, @amount, @currency].compact.join('.')}"

      if @hpp_fraud_filter_mode && @hpp_fraud_filter_mode != ''
        result_hash = "#{result_hash}.#{@hpp_fraud_filter_mode}"
      end
    end

    @hash = encode_hash result_hash, secret
    self
  end

  def generate_defaults(secret)

    if @timestamp.nil? || '' == @timestamp
      @timestamp = generate_timestamp
    end

    if @order_id.nil? || '' == @order_id
      @order_id = generate_order_id
    end

    build_hash secret
  end
end
