require 'json'

module Lucid
  module Shopify
    module Cache
      class Cache
        TTL = ENV['LUCID_SHOPIFY_CACHE_TTL'] || 3600

        #
        # @param namespace [String]
        # @param redis_client [Redis]
        #
        def initialize(namespace, redis_client = nil)
          @namespace = namespace
          @redis_client = redis_client || defined?(Redis) && Redis.current
        end

        attr_reader :namespace
        attr_reader :redis_client

        #
        # @param key [String]
        # @param seconds [Integer]
        # @yield a block returning the new cache value if required
        #
        def call(key, seconds = TTL, &value)
          k = namespaced_key(key)
          v = redis_client.get(k)

          return json_object?(v) ? JSON.parse(v) : v unless v.nil?

          value.().tap do |v2|
            redis_client.set(k, v2.to_json)
            redis_client.expire(k, seconds)
          end
        end

        private def namespaced_key(key)
          'lucid_shopify_cache:%s:%s' % [namespace, key]
        end

        private def json_object?(v)
          v.is_a?(String) && v.match?(/^{.*}$/)
        end

        #
        # Clear the cache for [key].
        #
        # @param key [String]
        #
        def clear(key)
          k = namespaced_key(key)

          redis_client.del(k)
        end
      end
    end
  end
end
