# Croudia

[![Build Status](https://travis-ci.org/wktk/croudia-gem.png)](https://travis-ci.org/wktk/croudia-gem)

Ruby wrapper for the [Croudia](https://croudia.com) API

This software is not affiliated with [Croudia Inc](http://croudia.co.jp/).
Croudia is a registered trademark of Croudia Inc. in Japan.

## Installation

Add this line to your application's Gemfile:

    gem "croudia", "~> 1.0"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install croudia

## Usage

### Getting an access token

``` ruby
require "croudia"

# Initialize a new instance
croudia = Croudia::Client.new(
  client_id: "client_id",
  client_secret: "client_secret"
)

# Get URL
url = croudia.authorize_url

# Or add state query in URL
url = croudia.authrorize_url(state: "state_value")

# Retrieve an access token
access_token = croudia.get_access_token("code param returned by user")
#=> { "access_token" => " ... ", "refresh_token" => " ... ", ... }

# Refresh an access token
new_access_token = croudia.get_access_token(
  grant_type: :refresh_token,
  refresh_token: "refresh_token"
)
```

### Using the API

``` ruby
require "croudia"

# Create an instance
croudia = Croudia::Client.new(access_token: "access_token")

# Get home_timeline
home_timeline = croudia.home_timeline

# Post a status
posted_status = croudia.update("Hello!")
```

The full documentation of `Croudia::Client` is available at:
http://rdoc.info/gems/croudia/Croudia/Client

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
