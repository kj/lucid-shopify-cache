require_relative './error'

module LucidShopify
  module Cache
    class RequestError < Error
      #
      # @param status [Integer] the HTTP response status
      #
      def initialize(status)
        @status = status
      end

      attr_reader :status
    end
  end
end
