# also encode request and response hash using SHA1
# frozen_string_literal: true

require 'date'
require 'securerandom'

# Generator generates default values for timestamp and order_id
module Generator
  def encode_hash(seed, secret)
    Digest::SHA1.hexdigest [Digest::SHA1.hexdigest(seed), secret].join('.')
  end

  def generate_timestamp
    DateTime.now.strftime '%Q'
  end

  def generate_order_id
    Base64.encode64 SecureRandom.uuid
  end
end
