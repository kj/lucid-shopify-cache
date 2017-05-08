$: << "#{__dir__}/lib"

require 'lucid_shopify_shop_cache/version'

task :default => :build

task :build do
  system 'gem build lucid-shopify-shop-cache.gemspec'
end

task :install => :build do
  system "gem install lucid-shopify-shop-cache-#{Lucid::Shopify::ShopCache::VERSION}.gem"
end

task :clean do
  system 'rm lucid-shopify-shop-cache-*.gem'
end
