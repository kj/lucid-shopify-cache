# frozen_string_literal: true

$LOAD_PATH << "#{__dir__}/lib"

require 'lucid_shopify/cache/version'

task(default: :build)
task(:build) { system 'gem build lucid_shopify-cache.gemspec' }
task(install: :build) { system "gem install lucid_shopify-cache-#{LucidShopify::Cache::VERSION}.gem" }
task(:clean) { system 'rm lucid_shopify-cache-*.gem' }
