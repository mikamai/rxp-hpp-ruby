module Request
  def sample_valid
    request = HppRequest.new
    request.merchant_id = "MerchantID"
    request.account = "myAccount"
    request.order_id = "OrderID"
    request.amount = "100"
    request.currency = "EUR"
    request.timestamp = "20990101120000"
    request.sha1hash = "5d8f05abd618e50db4861a61cc940112786474cf"
    request.auto_settle_flag = "1"
    request.comment1 = "a-z A-Z 0-9 ' \", + “” ._ - & \\ / @ ! ? % ( )* : £ $ & € # [ ] | = ;ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷ø¤ùúûüýþÿŒŽšœžŸ¥"
    request.comment2 = "Comment Two"
    request.return_tss = "0"
    request.shipping_code = "56|987"
    request.shipping_co = "IRELAND"
    request.billing_code = "123|56"
    request.billing_co = "IRELAND"
    request.cust_num = "123456"
    request.var_ref = "VariableRef"
    request.prod_id = "ProductID"
    request.hpp_lang = "EN"
    request.card_payment_button = "Submit Payment"
    request.card_storage_enable = "0"
    request.offer_save_card = "0"
    request.payer_ref = "PayerRef"
    request.pmt_ref = "PaymentRef"
    request.payer_exist = "0"
    request.validate_card_only = "0"
    request.dcc_enable = "0"
    request
  end

  def encoded_json
    {
      "MERCHANT_ID" => "TWVyY2hhbnRJRA==",
      "ACCOUNT" => "bXlBY2NvdW50",
      "ORDER_ID" => "T3JkZXJJRA==",
      "AMOUNT" => "MTAw",
      "CURRENCY" => "RVVS",
      "TIMESTAMP" => "MjA5OTAxMDExMjAwMDA=",
      "SHA1HASH" => "NWQ4ZjA1YWJkNjE4ZTUwZGI0ODYxYTYxY2M5NDAxMTI3ODY0NzRjZg==",
      "AUTO_SETTLE_FLAG" => "MQ==",
      "COMMENT1" => "YS16IEEtWiAwLTkgJyAiLCArIOKAnOKAnSAuXyAtICYgXCAvIEAgISA/ICUgKCApKiA6IMKjICQgJiDigqwgIyBbIF0gfCA9IDvDgMOBw4LDg8OEw4XDhsOHw4jDicOKw4vDjMONw47Dj8OQw5HDksOTw5TDlcOWw5fDmMOZw5rDm8Ocw53DnsOfw6DDocOiw6PDpMOlw6bDp8Oow6nDqsOrw6zDrcOuw6/DsMOxw7LDs8O0w7XDtsO3w7jCpMO5w7rDu8O8w73DvsO/xZLFvcWhxZPFvsW4wqU=",
      "COMMENT2" => "Q29tbWVudCBUd28=",
      "RETURN_TSS" => "MA==",
      "SHIPPING_CODE" => "NTZ8OTg3",
      "SHIPPING_CO" => "SVJFTEFORA==",
      "BILLING_CODE" => "MTIzfDU2",
      "BILLING_CO" => "SVJFTEFORA==",
      "CUST_NUM" => "MTIzNDU2",
      "VAR_REF" => "VmFyaWFibGVSZWY=",
      "PROD_ID" => "UHJvZHVjdElE",
      "HPP_LANG" => "RU4=",
      "CARD_PAYMENT_BUTTON" => "U3VibWl0IFBheW1lbnQ=",
      "CARD_STORAGE_ENABLE" => "MA==",
      "OFFER_SAVE_CARD" => "MA==",
      "PAYER_REF" => "UGF5ZXJSZWY=",
      "PMT_REF" => "UGF5bWVudFJlZg==",
      "PAYER_EXIST" => "MA==",
      "VALIDATE_CARD_ONLY" => "MA==",
      "DCC_ENABLE" => "MA=="
    }.to_json
  end
end
