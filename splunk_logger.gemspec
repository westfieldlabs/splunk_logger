# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'splunk_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "splunk_logger"
  spec.version       = SplunkLogger::VERSION
  spec.authors       = ["Michael Mell"]
  spec.email         = ["mike.mell@nthwave.net"]
  spec.description   = %q{A lightweight wrapper around Logger to optimize Splunk queries.}
  spec.summary       = %q{A lightweight wrapper around Logger to optimize Splunk queries by formatting logging as key/values.}
  spec.homepage      = "https://github.com/westfield/splunk_logger"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
