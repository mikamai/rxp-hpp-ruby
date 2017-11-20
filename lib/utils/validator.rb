# Validates HppRequest and HppResponse
module Validator
  RESPONSE_ERROR = 'HppResponse contains an invalid security hash'

  def validate_response(hpp_response, secret)
    return if hpp_response.valid_hash? secret
    fail RealexValidationException, RESPONSE_ERROR
  end

  def validate_request(_)
    true
  end
end
