# frozen_string_literal: true

require 'json'

module LucidShopify
  class Cache
    TTL = ENV['LUCID_SHOPIFY_CACHE_TTL'] || 3600

    #
    # @param namespace [String]
    # @param redis_client [Redis]
    #
    def initialize(namespace, redis_client: defined?(Redis) && Redis.current)
      @namespace = namespace
      @redis_client = redis_client
    end

    # @return [String]
    attr_reader :namespace
    # @return [Redis]
    attr_reader :redis_client

    #
    # @param key_object [#to_s]
    # @param ttl [Integer]
    #
    # @yield a block returning the new cache value if required
    #
    def call(key_object, ttl: TTL)
      key = serialize_key(key_object)
      cached_data = redis_client.get(key)

      return parse(cached_data) unless cached_data.nil?

      new_data = yield

      redis_client.set(key, new_data.to_json)
      redis_client.expire(key, ttl)

      new_data
    end

    #
    # @param key_object [#to_s]
    #
    # @return [String]
    #
    private def serialize_key(key_object)
      'lucid_shopify-cache:%s:%s' % [namespace, key_object.to_s]
    end

    #
    # @param data [String]
    #
    # @return [Hash, String] {Hash} when data looks like JSON
    #
    private def parse(data)
      return data unless data.is_a?(String) && data.match?(/^{.*}$/)

      JSON.parse(data)
    end

    #
    # Clear the cache for [key_object].
    #
    # @param key_object [#to_s]
    #
    def clear(key_object)
      redis_client.del(serialize_key(key_object))
    end
  end
end
