# frozen_string_literal: true

class Hash # :nodoc:
  def deep_transform_keys(&block)
    result = {}
    each do |key, value|
      result[yield(key)] = value.is_a?(Hash) ? value.deep_transform_keys(&block) : value
    end
    result
  end

  def camelize_keys
    deep_transform_keys { |key| key.to_s.camelize(false) }
  end

  def underscorize_keys
    deep_transform_keys { |key| key.to_s.underscore }
  end

  def rubify
    result = {}
    new_hash = self.delete_if {|key, value| key == '_links' }
    new_hash.each do |key, value|
      new_key = key.sanitize_key
      if key == '_embedded'
        result.merge!(value.rubify)
      elsif value.is_a?(Hash)
        result[new_key] = value.rubify
      elsif value.is_a?(Array)
        result[new_key] = []
        value.each do |val|
          result[new_key] << val.rubify
        end
      else
        result[new_key] = value
      end
    end
    result
  end
end

class String # :nodoc:
  def sanitize_key
    chars.first == "_" ? self[1..-1].underscore : self.underscore
  end

  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end

  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
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
