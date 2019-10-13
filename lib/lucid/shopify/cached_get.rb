# frozen_string_literal: true

require 'digest'
require 'net/http'
require 'uri'

require 'lucid/shopify/cache'

module Lucid
  module Shopify
    class CachedGet
      extend Dry::Initializer

      # @return [Cache]
      option :cache, default: proc { Cache.new }
      # @return [Lucid::Shopify::Client]
      option :client, default: proc { Client.new }

      # @see {Lucid::Shopify::Client#get}
      #
      # @param ttl [Integer]
      def call(*get_args, ttl: Cache::TTL)
        cache.(key(*get_args), ttl: ttl) { client.get(*get_args).to_h }.freeze
      end

      # @see {Lucid::Shopify::Client#get}
      #
      # @return [self]
      def clear(*get_args)
        cache.clear(key(*get_args))

        self
      end

      # @see {Lucid::Shopify::Client#get}
      private def key(credentials, path, params = {})
        Digest::MD5.hexdigest([
          credentials.myshopify_domain,
          path,
          params,
        ].join("\x1f")) # ASCII unit separator
      end
    end
  end
end
