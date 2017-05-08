$: << "#{__dir__}/lib"

require 'lucid_shopify_shop_cache/version'

Gem::Specification.new do |s|
  s.name = 'lucid-shopify-shop-cache'
  s.version = Lucid::Shopify::ShopCache::VERSION
  s.license = 'ISC'
  s.author = 'Kelsey Judson'
  s.email = 'kelsey@lucid.co.nz'
  s.summary = 'Cache Shopify API shop data'
  s.homepage = 'https://github.com/luciddesign/lucid-shopify-shop-cache'

  s.files = Dir.glob('lib/**/*') + [
    'README.md'
  ]
end
