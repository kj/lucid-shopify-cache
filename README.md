lucid_shopify-cache
===================

Installation
------------

Add the following lines to your ‘Gemfile’:

    git_source :lucid { |r| "https://github.com/lucidnz/gem-lucid_#{r}.git" }

    gem 'lucid_shopify-cache', lucid: 'shopify-cache'


Usage
-----

### Make a cached GET request

    require 'lucid_shopify/cached_get'

    cached_get = LucidShopify::CachedGet.new(client)
    
    args = ['orders', fields: %w(id tags)]
    
    cached_get.(args)
    cached_get.(args) # fetched from the cache

To clear the cache:

    cached_get.clear(args)


### Example: shop attributes

    args = ['shop', {}]

    cached_get.(args)['shop']

For the next hour, the data will be cached.

You might want to set the TTL to a high value and clear it only
when shop data actually changes. In this case, set up a ‘shop/update’
webhook which calls:

    cached_get.clear(args).(args)['shop']


### TTL

The default cache TTL is 3600 seconds (one hour), but this can be
changed by setting the environment variable ‘LUCID_SHOPIFY_CACHE_TTL’.
