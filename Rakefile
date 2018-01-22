$: << "#{__dir__}/lib"

require 'lucid_shopify/cache/version'

task default: :build

task :build do
  system 'gem build lucid_shopify-cache.gemspec'
end

task install: :build do
  system "gem install lucid_shopify-cache-#{LucidShopify::Cache::VERSION}.gem"
end

task :clean do
  system 'rm lucid_shopify-cache-*.gem'
end
