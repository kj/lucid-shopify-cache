require 'net/http'
require 'uri'

require_relative '../cache'

module Lucid
  module Shopify
    class Cache
      class Shop
        RequestError = Class.new(StandardError)

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
          @attributes ||= cache.('attributes') { api_attributes }
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

        private def api_attributes
          uri = URI('https://%s/admin/shop.json' % myshopify_domain)

          req = Net::HTTP::Get.new(uri)
          req['Accept'] = 'application/json'
          req['X-Shopify-Access-Token'] = access_token
          res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |h| h.request(req) }

          if res.code.to_i != 200
            raise RequestError, 'invalid response code %s' % res.code.to_i
          end

          api_attributes_parse(res.body)
        end

        private def api_attributes_parse(body)
          JSON.parse(body)['shop']
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
