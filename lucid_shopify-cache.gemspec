# frozen_string_literal: true

$LOAD_PATH.unshift "#{__dir__}/lib"

require 'lucid_shopify/cache/version'

Gem::Specification.new do |s|
  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'rubocop', '0.67'
  s.add_runtime_dependency 'cbor', '~> 0.5'
  s.add_runtime_dependency 'dry-initializer', '~> 3.0'
  s.add_runtime_dependency 'lucid_shopify', '~> 0.27'
  s.add_runtime_dependency 'redis', '~> 4.1'
  s.author = 'Kelsey Judson'
  s.email = 'kelsey@lucid.nz'
  s.files = Dir.glob('lib/**/*') + %w(README.md)
  s.homepage = 'https://github.com/lucidnz/gem-lucid_shopify-cache'
  s.license = 'ISC'
  s.name = 'lucid_shopify-cache'
  s.summary = 'Cache Shopify API data'
  s.version = LucidShopify::Cache::VERSION
end
