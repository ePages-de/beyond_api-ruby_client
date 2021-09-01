# frozen_string_literal: true

module BeyondApi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __dir__)

      def copy_initializer
        template "beyond_api_initializer.rb", "config/initializers/beyond_api.rb"
      end
    end
  end
end
