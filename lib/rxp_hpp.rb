# RealexHpp class for converting HPP requests and responses to and from JSON.
# This class is also responsible for validating inputs, generating defaults and encoding parameter values.
require 'hpp_request'
require 'hpp_response'

class RealexHpp

  def initialize(secret)
    @secret = secret
  end

  def request_to_json(hpp_request)
    hpp_request
      .build_hash(@secret)
      .encode
      .to_json
  end

  def request_from_json(json, encoded = true)
    hpp_request = HppRequest.new json
    hpp_request.decode if encoded
    hpp_request
  end

  def response_to_json(hpp_response)
    hpp_response
      .build_hash(@secret)
      .encode
      .to_json
  end

  def response_from_json(json, encoded = true)
    hpp_response = HppResponse.new json
    hpp_response.decode if encoded
    hpp_response
  end
end
