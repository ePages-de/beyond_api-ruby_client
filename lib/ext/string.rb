# frozen_string_literal: true

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
      string = string.sub(/^[a-z\d]*/, &:capitalize)
    else
      string = string.sub(/^(?:(?=\b|[A-Z_])|\w)/, &:downcase)
    end
    string.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.gsub("/", "::")
  end
end
