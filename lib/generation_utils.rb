class GenerationUtils
  def self.generate_hash(seed, secret)
    Digest::SHA1.hexdigest [Digest::SHA1.hexdigest(seed), secret].join(',')
  end

  def self.generate_timestamp
    Time.now.to_s
  end

  def self.generate_order_id
    SecureRandom.base64
  end
end
