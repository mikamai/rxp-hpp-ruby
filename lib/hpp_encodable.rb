class HppEncodable
  FIELDS = []
  JSON_IGNORE = [:@hash]
  MAP_FIELDS = []

  def initialize(json = '{}')
    JSON.parse(json).each do |key, value|
      instance_key = "@#{key.downcase}"
      if self.class::MAP_FIELDS.include? :"#{key.downcase}"
        instance_variable_set instance_key, value
      elsif self.class::FIELDS.include? :"#{key.downcase}"
        instance_variable_set instance_key, value
      end
    end
  end

  def apply_to_all
    self.class::FIELDS.each do |field|
      value = send(field).to_s
      instance_variable_set "@#{field}", yield(field, value)
    end
  end

  def encode
    apply_to_all do |field, value|
      if self.class::MAP_FIELDS.include? :"#{field}"
        self.send(field).each do |key, k_value|
          self.send(field)[key] = Base64.encode64(k_value).force_encoding 'UTF-8'
        end
        self.send(field)
      else
        Base64.encode64(value).force_encoding 'UTF-8'
      end
    end
    self
  end

  def decode
    apply_to_all do |field, value|
      if self.class::MAP_FIELDS.include? :"#{field}"
        self.send(field).each do |key, k_value|
          self.send(field)[key] = Base64.decode64(k_value).force_encoding 'UTF-8'
        end
        self.send(field)
      else
        Base64.decode64(value).force_encoding 'UTF-8'
      end
    end
    self
  end

  def to_json
    (instance_variables - self.class::JSON_IGNORE).each_with_object({}) do |var, hash|
      hash[var.to_s.delete('@')] = instance_variable_get var
    end.to_json
  end
end
