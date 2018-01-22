# frozen_string_literal: true

require 'lucid_shopify/cache/errors/error'

module LucidShopify
  module Cache
    class RequestError < Error
      #
      # @param status [Integer] the HTTP response status
      #
      def initialize(status)
        @status = status
      end

      # @return [Integer]
      attr_reader :status
    end
  end
end
