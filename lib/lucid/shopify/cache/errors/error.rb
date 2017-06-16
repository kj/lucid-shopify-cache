module Lucid
  module Shopify
    module Cache
      #
      # Subclass this class for all gem exceptions, so that callers may rescue
      # any subclass with:
      #
      #     rescue Lucid::Shopify::Cache::Error => e
      #
      class Error < StandardError
      end
    end
  end
end
