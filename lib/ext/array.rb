# frozen_string_literal: true

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
