# Tolq::Api

The Tolq Api gem wraps our api, making it a lot easier to integrate it with your Ruby application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tolq-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tolq-api

## Usage

For an overview of how our api works, see [the documentation](http://docs.tolq.com/docs/api-getting-started).

First, you need to create a a client.

```ruby
client = Tolq::Api::Client.new(ENV['TOLQAPIKEY'], ENV['TOLQAPISECRET'])
```

_Before making any translation requests, make sure you have set up your billing information
correctly._


You can directly create and order a translation request:

```ruby
response = client.translation_requests.create(
    "request" => {
        "a.key" => {
            "text" => "A sentence to translate"
        }
    },
    "source_language_code" => "en",
    "target_language_code" => "nl",
    "quality" => "standard",
    "options" => {
        "name" => "My translation request",
        "callback_url" => "https://mysite.com/translations_finished"
    }

)

response.class # Tolq::Api::Response
response.body # A tolq response as per the documentation. This JSON and can be parsed using your favourite json parser
```

When present, Tolq will make a callback to the callback url when the translations have been fully finished.

You can also create a quote, these will not be ordered directly and need your confirmation.

```ruby
response = client.translation_requests.quote(
    "request" => {
        "a.key" => {
            "text" => "A sentence to translate"
        }
    },
    "source_language_code" => "en",
    "target_language_code" => "nl",
    "quality" => "standard",
    "options" => {
        "name" => "My translation request",
        "callback_url" => "https://mysite.com/translations_finished"
    }

)

response.class # Tolq::Api::Response
response.body # A tolq response as per the documentation. This JSON and can be parsed using your favourite json parser
```

After creating the quote, you can order it:

```ruby
client.translation_request.order(response.id)
```

If you do not have a callback url or are just interested in the status, you can request the status and/or translations as follows:

```ruby
response = client.translation_requests.show(<id>)
response.class # Tolq::Api::Response
response.body # A tolq response as per the documentation. This JSON and can be parsed using your favourite json parser
```

For more details on on the library please refer to the [gem documentation](TODO). For more details on possible values see the [api documentation](https://docs.tolq.com).

## Development

TODO

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tolq-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

