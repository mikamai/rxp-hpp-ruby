# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'rxp_hpp'
  s.version     = '0.0.1'
  s.date        = '2017-11-10'
  s.summary     = 'Ruby SDK for Realex HPP'
  s.description = 'As simple Ruby SDK for Realex HPP'
  s.authors     = ['Alberto Pellizzon']
  s.email       = 'alberto@mikami.cpm'
  s.files = Dir['lib/*.rb'] + Dir['lib/utils/*.rb'] + Dir['spec/**/*']
  s.require_paths = ['lib']
  s.add_development_dependency 'rspec', '~>3'
  s.license = 'MIT'
end
