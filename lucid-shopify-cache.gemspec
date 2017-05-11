$: << "#{__dir__}/lib"

require 'lucid/shopify/cache/version'

Gem::Specification.new do |s|
  s.add_development_dependency 'rspec', '~> 3.6.0'
  s.author = 'Kelsey Judson'
  s.email = 'kelsey@lucid.co.nz'
  s.files = Dir.glob('lib/**/*') + %w(README.md)
  s.homepage = 'https://github.com/luciddesign/lucid-shopify-cache'
  s.license = 'ISC'
  s.name = 'lucid-shopify-cache'
  s.summary = 'Cache Shopify API data'
  s.version = Lucid::Shopify::Cache::VERSION
end
