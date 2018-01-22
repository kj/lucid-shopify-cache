module LucidShopify
  module Cache
    #
    # Subclass this class for all gem exceptions, so that callers may rescue
    # any subclass with:
    #
    #     rescue LucidShopify::Cache::Error => e
    #
    class Error < StandardError
    end
  end
end
