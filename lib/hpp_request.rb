require 'generation_utils'

class HppRequest
  require 'base64'
  require 'json'

  FIELDS = [
    :merchant_id,
    :account,
    :order_id,
    :amount,
    :currency,
    :timestamp,
    :sha1_hash,
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

  attr_accessor *FIELDS

  def initialize(json = '{}')
    JSON.parse(json).each { |key, value| instance_variable_set("@#{key}", value) }
  end

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

    @hash = GenerationUtils.generate_hash(result_hash, secret)
    self
  end

  def generate_defaults(secret)

    if @timestamp.nil? || '' == @timestamp
      @timestamp = GenerationUtils.generate_timestamp
    end

    if @order_id.nil? || '' == @order_id
      @order_id = GenerationUtils.generate_order_id
    end

    build_hash secret
  end

  def apply_to_all
    FIELDS.each do |field|
      value = send(field).to_s
      instance_variable_set "@#{field}", yield(value)
    end
  end

  def encode
    apply_to_all { |field| Base64.encode64(field).force_encoding('UTF-8') }
    self
  end

  def decode
    apply_to_all { |field| Base64.decode64(field).force_encoding('UTF-8') }
    self
  end

  def to_json
    instance_variables
      .each_with_object({}) do |var, hash|
        hash[var.to_s.delete('@')] = instance_variable_get(var)
      end.to_json
  end
end
