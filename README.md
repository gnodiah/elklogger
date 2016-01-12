# ElkLogger

A formatted logger for ELK-stack.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elklogger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elklogger

## Usage

First, execute the following command to generate config file:

```shel
elklogger config:install
```

then you can use it like this in your ruby source files:

```ruby
logger = ElkLogger.new('/tmp/filename.log.elk') # Create log file, filename MUST be ending with '.elk'
logger.info 'hello logger!'  # Use 'info' level to log information
logger.close
```

**NOTE:** logfile's postfix MUST BE `.elk`, this is important, because only `.elk` files will be supported.

And the supported log levels are (ordered by level ASC):

- debug
- info
- warn
- error

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gnodiah/elklogger.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

