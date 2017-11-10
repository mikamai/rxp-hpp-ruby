# RealexHpp class for converting HPP requests and responses to and from JSON.
# This class is also responsible for validating inputs, generating defaults and encoding parameter values.
require 'hpp_request'
require 'hpp_response'

class RealexHpp

  def initialize(secret)
    @secret = secret
  end

  def request_to_json(hpp_request)
    hpp_request.generate_defaults @secret

    begin
      hpp_request.encode
    rescue Exception => ex
      raise Exception.new('Exception encoding HPP request.')
    end

    hpp_request.to_json
  end

  def request_from_json(json, encoded = true)
    hpp_request = HppRequest.new json
    if encoded
      begin
        hpp_request.decode
      rescue Exception => ex
        raise Exception.new('Exception decoding HPP request.')
      end
    end

    hpp_request
  end

  def response_to_json(hpp_response)
    hpp_response.build_hash(secret)

    begin
      hpp_response = hpp_response.encode
    rescue Exception => ex
      raise Exception.new('Exception encoding HPP response.')
    end

    hpp_response.to_json
  end

  def response_from_json(json, encoded = true)
    hpp_response = HppResponse.new json

    if encoded
      begin
        hpp_response = hpp_response.decode
      rescue Exception => ex
        Exception.new('Exception decoding HPP response.')
      end
    end

    hpp_response
  end
end
