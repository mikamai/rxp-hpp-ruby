Gem::Specification.new do |s|
  s.name        = 'rxp_hpp'
  s.version     = '0.0.0'
  s.date        = '2017-11-10'
  s.summary     = 'Hola!'
  s.description = 'A simple hello world gem'
  s.authors     = ['Alberto Pellizzon']
  s.email       = 'alberto@mikami.cpm'
  s.files       =  Dir['lib/*.rb'] + Dir['spec/**/*']
  s.require_paths = ['lib']
  s.add_development_dependency 'rspec', '~>3'
  s.license       = 'MIT'
end
