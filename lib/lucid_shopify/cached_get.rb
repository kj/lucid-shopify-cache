# frozen_string_literal: true

require 'net/http'
require 'uri'

require 'lucid_shopify/cache'

module LucidShopify
  class CachedGet
    extend Dry::Initializer

    # @return [Cache]
    option :cache, default: proc { Cache.new }
    # @return [LucidShopify::Client]
    option :client, default: proc { Client.new }

    #
    # @see {LucidShopify::Client#get}
    #
    # @param ttl [Integer]
    #
    def call(*get_args, ttl: Cache::TTL)
      cache.(key(*get_args), ttl: ttl) { client.get(*get_args) }.freeze
    end

    #
    # @see {LucidShopify::Client#get}
    #
    # @return [self]
    #
    def clear(*get_args)
      cache.clear(key(*get_args))

      self
    end

    #
    # @see {LucidShopify::Client#get}
    #
    private def key(credentials, path, params = {})
      [
        credentials.myshopify_domain,
        path,
        params,
      ].join(':')
    end
  end
end
