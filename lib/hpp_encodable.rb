# frozen_string_literal: true

# HppEncodable allows to encode / decode Hpp request and response
class HppEncodable
  FIELDS = [].freeze
  JSON_IGNORE = [].freeze
  MAP_FIELDS = [].freeze

  def initialize(json = '{}')
    JSON.parse(json).each do |key, value|
      if self.class::FIELDS.include? :"#{key.downcase}"
        instance_variable_set "@#{key.downcase}", value
      end
    end
  end

  def apply_all
    self.class::FIELDS.each do |field|
      instance_variable_set(
        "@#{field}",
        if self.class::MAP_FIELDS.include? :"#{field}"
          (send(field) || {}).map { |key, value| [key, yield(value)] }.to_h
        else
          yield send(field).to_s
        end
      )
    end
  end

  def encode
    apply_all { |value| Base64.strict_encode64(value).force_encoding 'UTF-8' }
    self
  end

  def decode
    apply_all { |value| Base64.decode64(value).force_encoding 'UTF-8' }
    self
  end

  def to_json
    json_keys = self.class::FIELDS - self.class::JSON_IGNORE
    json_keys.each_with_object({}) do |field, hash|
      hash["#{field}".upcase] = send field
    end.to_json
  end

  private

  def value_or_empty(value)
    value || ''
  end
end
