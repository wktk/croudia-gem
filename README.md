# Croudia

A Mechanize-based scraper for [Croudia](https://croudia.com)

## Installation

Add this line to your application's Gemfile:

    gem 'croudia'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install croudia

## Usage

```ruby
require 'croudia'

# Create a new instance
croudia = Croudia.new('username', 'password')

# Same as above
croudia = Croudia.new
croudia.login('username', 'password')

# Update status
croudia.update('Hello!')

# Follow @wktk
croudia.follow('wktk')

# Get the home timeline
croudia.timeline
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
