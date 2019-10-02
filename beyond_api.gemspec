
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "beyond_api/version"

Gem::Specification.new do |spec|
  spec.name          = "beyond_api"
  spec.version       = BeyondApi::VERSION
  spec.authors       = ["Unai Abrisketa", "German San Emeterio", "Kathia Salazar"]

  spec.summary       = %q{Ruby client to access the Beyond Api}
  spec.summary       = "Ruby client to access the Beyond API"
  spec.homepage      = "https://github.com/ePages-de/beyond_api"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.5.1"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.0"
  spec.add_development_dependency "yard",    "~> 0.9"
  spec.add_development_dependency "faker",   "~> 2.2"
  spec.add_development_dependency "dotenv",  "~> 2.7"

  spec.add_dependency "faraday", "~> 0.15"
end
