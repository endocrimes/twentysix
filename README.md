# Twentysix

Completely unofficial Ruby gem for the N26 API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twentysix'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twentysix

### Usage

```ruby
require 'twentysix'

client = TwentySix::Core.authenticate(ENV["N26_USERNAME"], ENV["N26_PASSWORD"])
puts client.transactions(count: 3)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/DanToml/twentysix. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

