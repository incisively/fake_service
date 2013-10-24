# FakeService

Fake service for reqres. It takes generated file by reqres, define actions and
runs server.

## Installation

Add this line to your application's Gemfile:

    gem 'fake_service'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fake_service

## Usage

    $ fake_service path/to/file

fake_service behaves like Rack::Server and can accept different options:

    $ fake_service path/to/file -D -p 4567 -P path/to/pid

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
