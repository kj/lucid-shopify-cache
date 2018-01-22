# frozen_string_literal: true

module LucidShopify
  module Cache
    #
    # Subclass this class for all gem exceptions, so that callers may rescue
    # any subclass with:
    #
    #     rescue LucidShopify::Cache::Error => e
    #
    Error = Class.new(StandardError)
  end
end
