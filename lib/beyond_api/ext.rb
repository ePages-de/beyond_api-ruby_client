# frozen_string_literal: true

class Hash
  def deep_transform_keys(&block)
    result = {}
    each do |key, value|
      result[yield(key)] = case value
                           when Hash
                             value.deep_transform_keys(&block)
                           when Array
                             value.camelize_keys
                           else
                             value
                           end
    end
    result
  end

  def camelize_keys
    deep_transform_keys { |key| key.to_s.camelize(false) }
  end

  def underscorize_keys
    deep_transform_keys { |key| key.to_s.underscore }
  end
end

class String
  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end

  def underscore
    gsub(/::/, "/")
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr("-", "_")
      .downcase
  end

  def camelize(uppercase_first_letter = true)
    string = self
    if uppercase_first_letter
      string = string.sub(/^[a-z\d]*/) { |match| match.capitalize }
    else
      string = string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { |match| match.downcase }
    end
    string.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.gsub("/", "::")
  end
end

class Array
  def camelize_keys
    map do |elem|
      case elem
      when Hash, Array then elem.camelize_keys
      else; elem
      end
    end
  end
end
