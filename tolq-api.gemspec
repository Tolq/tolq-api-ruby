# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tolq-api/version'

Gem::Specification.new do |spec|
  spec.name          = 'tolq-api'
  spec.version       = Tolq::Api::VERSION
  spec.authors       = ['Timon Vonk']
  spec.email         = ['timon@tolq.com']

  spec.summary       = 'A gem that wraps the Tolq.com API'
  spec.description   = 'A gem that wraps the Tolq.com API'
  spec.homepage      = "https://www.github.com/tolq/tolq-api-ruby"
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = []
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'webmock'
end
