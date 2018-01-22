lucid_shopify-cache
===================

Installation
------------

Add the following lines to your ‘Gemfile’:

    git_source :lucid { |r| "https://github.com/lucidnz/gem-lucid_#{r}.git" }

    gem 'lucid_shopify-cache', lucid: 'shopify-cache'


Usage
-----

    require 'lucid_shopify/cache'
    require 'lucid_shopify/cache/shop'

### Shop attributes

    myshopify_domain = ...
    access_token = ...

    shop = LucidShopify::Cache::Shop.new(myshopify_domain, access_token)

    shop.attributes

For the next hour, the data will be cached. To return fresh data:

    shop.attributes!


### TTL

The default cache TTL is 3600, but this can be changed by setting
the environment variable ‘LUCID_SHOPIFY_CACHE_TTL’.


### Manually clearing the cache

You might want to set the cache to a high value and clear it only
when shop data actually changes. In this case, set up a ‘shop/update’
webhook which calls:

    shop.clear

The next time `#attributes` is called, it will pull fresh data.

Note that this optimization is completely optional.
