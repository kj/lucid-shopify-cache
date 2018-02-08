# frozen_string_literal: true

require 'net/http'
require 'uri'

require 'lucid_shopify/cache'

module LucidShopify
  class CachedGet
    #
    # @param client [LucidShopify::Client]
    # @param redis_client [Redis]
    #
    def initialize(client, redis_client: defined?(Redis) && Redis.current)
      @client = client
      @redis_client = redis_client
    end

    # @return [LucidShopify::Client]
    attr_reader :client
    # @return [Redis]
    attr_reader :redis_client

    #
    # @param args [Array] see {LucidShopify::Client#get}
    # @param ttl [Integer]
    #
    def call(args, ttl: Cache::TTL)
      @data ||=
        cache.(args) { client.get(*args) }.freeze
    end

    #
    # @return [Cache]
    #
    private def cache
      @cache ||=
        Cache.new(client.shop_credentials.myshopify_domain, redis_client: redis_client)
    end

    #
    # @param args [Array] see {LucidShopify::Client#get}
    #
    # @return [self]
    #
    def clear(args)
      @data = nil

      cache.clear(args)

      self
    end
  end
end
