require_relative '../cache'

module Lucid
  module Shopify
    class Cache
      class Shop
        attr_accessor :myshopify_domain, :access_token, :redis_client

        #
        # @param myshopify_domain [String]
        # @param access_token [String]
        # @param redis_client [Redis]
        #
        def initialize(myshopify_domain, access_token, redis_client = nil)
          @myshopify_domain = myshopify_domain
          @access_token = access_token
          @redis_client = redis_client || defined?(Redis) && Redis.current
        end

        #
        # Get shop attributes hash from API or cache.
        #
        # @return [Hash]
        #
        def attributes
          @attributes ||= cache('attributes') { get_attributes }
        end

        #
        # Get shop attributes hash from API after clearing cache (always get the
        # most up to date data). Use this when accuracy is important.
        #
        # @return [Hash]
        #
        def attributes!
          clear

          attributes
        end

        private def cache
          @cache ||= Cache.new('shops:%s' % myshopify_domain, redis_client)
        end

        private def get_attributes
          # TODO: query API using Net::HTTP.
        end

        #
        # Clear the attributes cache.
        #
        def clear
          @attributes = nil

          cache.clear('attributes')
        end
      end
    end
  end
end
