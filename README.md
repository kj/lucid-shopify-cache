lucid-shopify-cache
===================

Installation
------------

Add the following line to your ‘Gemfile’:

    gem 'lucid-shopify-cache', github: 'luciddesign/gem-lucid-shopify-cache'


Usage
-----

    require 'lucid/shopify/cache'
    require 'lucid/shopify/cache/shop'

Get shop data with:

    myshopify_domain = ...
    access_token = ...
    redis_client = ... # (optional, defaults to `Redis.current`)

    shop = Lucid::Shopify::Cache::Shop.new(myshopify_domain, access_token, redis_client)

    shop.attributes

For the next hour, the shop data will be cached. To return fresh data:

    shop.attributes!
