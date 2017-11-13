require 'date'
require 'securerandom'

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
