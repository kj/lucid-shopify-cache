# frozen_string_literal: true

require 'json'

module LucidShopify
  class Cache
    TTL = ENV['LUCID_SHOPIFY_CACHE_TTL'] || 3600

    extend Dry::Initializer

    # @return [String]
    param :namespace, default: proc { 'lucid_shopify-cache' }
    # @return [Redis]
    option :redis_client, default: proc { defined?(Redis) && Redis.current }

    #
    # Create a new instance with a new namespace appended to the current one.
    #
    # @param new_namespace [String]
    #
    # @return [Cache]
    #
    # @example
    #   cache.add_namespace(myshopify_domain)
    #
    # @example Using the {+} operator alias
    #   cache + myshopify_domain
    #
    def add_namespace(new_namespace)
      self.class.new("#{namespace}:#{new_namespace}", redis_client)
    end

    alias_method :+, :add_namespace

    #
    # Fetch value from the cache, falling back to the given block when the cache
    # is empty.
    #
    # @param key [String]
    # @param ttl [Integer]
    #
    # @yieldreturn [#to_json]
    #
    # @return [Object]
    #
    def call(key, ttl: TTL)
      key = namespaced_key(key)

      fetch(key) || cache(key, yield, ttl)
    end

    #
    # @param key [String]
    #
    # @return [Object, nil]
    #
    private def fetch(key)
      val = redis_client.get(key)

      val && JSON.parse(val)
    end

    #
    # @param key [String]
    # @param val [#to_json]
    # @param ttl [Integer]
    #
    # @return [Object]
    #
    private def cache(key, val, ttl)
      redis_client.set(key, val.to_json)
      redis_client.expire(key, ttl)

      val
    end

    #
    # @param key [String]
    #
    # @return [String]
    #
    private def namespaced_key(key)
      "#{namespace}:#{key}"
    end

    #
    # @param key [String]
    #
    def clear(key)
      redis_client.del(namespaced_key(key))
    end
  end
end
