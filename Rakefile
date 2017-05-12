$: << "#{__dir__}/lib"

require 'lucid/shopify/cache/version'

task default: :build

task :build do
  system 'gem build lucid-shopify-cache.gemspec'
end

task install: :build do
  system "gem install lucid-shopify-cache-#{Lucid::Shopify::Cache::VERSION}.gem"
end

task :clean do
  system 'rm lucid-shopify-cache-*.gem'
end
