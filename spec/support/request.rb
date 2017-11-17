# frozen_string_literal: true

module Request
  def valid_hpp_request(with_card_storage = false)
    request = HppRequest.new
    seed = with_card_storage ? valid_request_with_card_storage : valid_request
    seed.each do |key, value|
      request.send "#{key.downcase}=", value
    end
    request
  end

  def encoded_request
    {
      'MERCHANT_ID' => 'TWVyY2hhbnRJRA==',
      'ACCOUNT' => 'bXlBY2NvdW50',
      'ORDER_ID' => 'T3JkZXJJRA==',
      'AMOUNT' => 'MTAw',
      'CURRENCY' => 'RVVS',
      'TIMESTAMP' => 'MjA5OTAxMDExMjAwMDA=',
      'SHA1HASH' => 'NWQ4ZjA1YWJkNjE4ZTUwZGI0ODYxYTYxY2M5NDAxMTI3ODY0NzRjZg==',
      'AUTO_SETTLE_FLAG' => 'MQ==',
      'COMMENT1' => 'YS16IEEtWiAwLTkgJyAiLCArIOKAnOKAnSAuXyAtICYgXCAvIEAgISA/ICUgKCApKiA6IMKjICQgJiDigqwgIyBbIF0gfCA9IDvDgMOBw4LDg8OEw4XDhsOHw4jDicOKw4vDjMONw47Dj8OQw5HDksOTw5TDlcOWw5fDmMOZw5rDm8Ocw53DnsOfw6DDocOiw6PDpMOlw6bDp8Oow6nDqsOrw6zDrcOuw6/DsMOxw7LDs8O0w7XDtsO3w7jCpMO5w7rDu8O8w73DvsO/xZLFvcWhxZPFvsW4wqU=',
      'COMMENT2' => 'Q29tbWVudCBUd28=',
      'RETURN_TSS' => 'MA==',
      'SHIPPING_CODE' => 'NTZ8OTg3',
      'SHIPPING_CO' => 'SVJFTEFORA==',
      'BILLING_CODE' => 'MTIzfDU2',
      'BILLING_CO' => 'SVJFTEFORA==',
      'CUST_NUM' => 'MTIzNDU2',
      'VAR_REF' => 'VmFyaWFibGVSZWY=',
      'PROD_ID' => 'UHJvZHVjdElE',
      'HPP_LANG' => 'RU4=',
      'CARD_PAYMENT_BUTTON' => 'U3VibWl0IFBheW1lbnQ=',
      'CARD_STORAGE_ENABLE' => 'MA==',
      'OFFER_SAVE_CARD' => 'MA==',
      'PAYER_REF' => 'UGF5ZXJSZWY=',
      'PMT_REF' => 'UGF5bWVudFJlZg==',
      'PAYER_EXIST' => 'MA==',
      'VALIDATE_CARD_ONLY' => 'MA==',
      'DCC_ENABLE' => 'MA=='
    }
  end

  def valid_request
    {
      'MERCHANT_ID' => 'MerchantID',
      'ACCOUNT' => 'myAccount',
      'ORDER_ID' => 'OrderID',
      'AMOUNT' => '100',
      'CURRENCY' => 'EUR',
      'TIMESTAMP' => '20990101120000',
      'SHA1HASH' => '5d8f05abd618e50db4861a61cc940112786474cf',
      'AUTO_SETTLE_FLAG' => '1',
      'COMMENT1' => "a-z A-Z 0-9 ' \", + “” ._ - & \\ / @ ! ? % ( )* : £ $ & € # [ ] | = ;ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷ø¤ùúûüýþÿŒŽšœžŸ¥",
      'COMMENT2' => 'Comment Two',
      'RETURN_TSS' => '0',
      'SHIPPING_CODE' => '56|987',
      'SHIPPING_CO' => 'IRELAND',
      'BILLING_CODE' => '123|56',
      'BILLING_CO' => 'IRELAND',
      'CUST_NUM' => '123456',
      'VAR_REF' => 'VariableRef',
      'PROD_ID' => 'ProductID',
      'HPP_LANG' => 'EN',
      'CARD_PAYMENT_BUTTON' => 'Submit Payment',
      'CARD_STORAGE_ENABLE' => '0',
      'OFFER_SAVE_CARD' => '0',
      'PAYER_REF' => 'PayerRef',
      'PMT_REF' => 'PaymentRef',
      'PAYER_EXIST' => '0',
      'VALIDATE_CARD_ONLY' => '0',
      'DCC_ENABLE' => '0'
    }
  end

  def valid_request_with_card_storage
    valid_request.tap do |request|
      request['CARD_STORAGE_ENABLE'] = '1'
      request['OFFER_SAVE_CARD'] = '1'
    end
  end
end
