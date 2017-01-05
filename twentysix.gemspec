# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twentysix/version'

Gem::Specification.new do |spec|
  spec.name          = 'twentysix'
  spec.version       = TwentySix::VERSION
  spec.authors       = ['Danielle Tomlinson']
  spec.email         = ['dan@tomlinson.io']

  spec.summary       = 'A small wrapper around the n26 Banking API.'
  spec.homepage      = 'https://github.com/dantoml/twentysix'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'deep_merge'

  spec.add_development_dependency 'bundler', '~> 1.13.a'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
