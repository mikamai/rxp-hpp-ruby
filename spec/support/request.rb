module Request
  def sample_valid
    request = HppRequest.new
    request.merchant_id = "MerchantID"
    request.account = "myAccount"
    request.order_id = "OrderID"
    request.amount = "100"
    request.currency = "EUR"
    request.timestamp = "20990101120000"
    request.sha1_hash = "5d8f05abd618e50db4861a61cc940112786474cf"
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
end
