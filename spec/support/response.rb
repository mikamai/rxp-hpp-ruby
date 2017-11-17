# frozen_string_literal: true

module Response
  def valid_hpp_response
    response = HppResponse.new
    valid_response.each do |key, value|
      response.send "#{key.downcase}=", value
    end
    response
  end

  def valid_response
    {
      'MERCHANT_ID' => 'thestore',
      'ACCOUNT' => 'myAccount',
      'ORDER_ID' => 'ORD453-11',
      'AMOUNT' => '100',
      'AUTHCODE' => '79347',
      'TIMESTAMP' => '20130814122239',
      'SHA1HASH' => 'f093a0b233daa15f2bf44888f4fe75cb652e7bf0',
      'RESULT' => '00',
      'MESSAGE' => 'Successful',
      'CVNRESULT' => '1',
      'PASREF' => '3737468273643',
      'BATCHID' => '654321',
      'ECI' => '1',
      'CAVV' => '123',
      'XID' => '654564564',
      'COMMENT1' => "a-z A-Z 0-9 ' \", + “” ._ - & \\ / @ ! ? % ( )* : £ $ & € # [ ] | = ;ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷ø¤ùúûüýþÿŒŽšœžŸ¥",
      'COMMENT2' => 'Comment Two',
      'TSS' => {
        'TSS_2' => 'TSS_2_VALUE',
        'TSS_1' => 'TSS_1_VALUE'
      }
    }
  end

  def encoded_response
    {
      'MERCHANT_ID' => 'dGhlc3RvcmU=',
      'ACCOUNT' => 'bXlBY2NvdW50',
      'ORDER_ID' => 'T1JENDUzLTEx',
      'AMOUNT' => 'MTAw',
      'AUTHCODE' => 'NzkzNDc=',
      'TIMESTAMP' => 'MjAxMzA4MTQxMjIyMzk=',
      'SHA1HASH' => 'ZjA5M2EwYjIzM2RhYTE1ZjJiZjQ0ODg4ZjRmZTc1Y2I2NTJlN2JmMA==',
      'RESULT' => 'MDA=',
      'MESSAGE' => 'U3VjY2Vzc2Z1bA==',
      'CVNRESULT' => 'MQ==',
      'PASREF' => 'MzczNzQ2ODI3MzY0Mw==',
      'BATCHID' => 'NjU0MzIx',
      'ECI' => 'MQ==',
      'CAVV' => 'MTIz',
      'XID' => 'NjU0NTY0NTY0',
      'COMMENT1' => 'YS16IEEtWiAwLTkgJyAiLCArIOKAnOKAnSAuXyAtICYgXCAvIEAgISA/ICUgKCApKiA6IMKjICQgJiDigqwgIyBbIF0gfCA9IDvDgMOBw4LDg8OEw4XDhsOHw4jDicOKw4vDjMONw47Dj8OQw5HDksOTw5TDlcOWw5fDmMOZw5rDm8Ocw53DnsOfw6DDocOiw6PDpMOlw6bDp8Oow6nDqsOrw6zDrcOuw6/DsMOxw7LDs8O0w7XDtsO3w7jCpMO5w7rDu8O8w73DvsO/xZLFvcWhxZPFvsW4wqU=',
      'COMMENT2' => 'Q29tbWVudCBUd28=',
      'TSS' => {
        'TSS_2' => 'VFNTXzJfVkFMVUU=',
        'TSS_1' => 'VFNTXzFfVkFMVUU='
      },
      'UNKNOWN_4' => 'VW5rbm93biB2YWx1ZSA0',
      'UNKNOWN_3' => 'VW5rbm93biB2YWx1ZSAz',
      'UNKNOWN_2' => 'VW5rbm93biB2YWx1ZSAy',
      'UNKNOWN_1' => 'VW5rbm93biB2YWx1ZSAx'
    }
  end
end
