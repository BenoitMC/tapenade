# Tapenade

Tapenade allows to chain method after `tap` instead of using a block.

## Examples

```ruby
# With Ruby's tap
User.find(param[:id]).tap { |user| user.update!(user_params) }
# => returns the user

# With Tapenade:
User.find(param[:id]).tap.update!(user_params)
# => returns the user
```

Examples are using Rails models but it works with any method on any object.

You can of course still use `tap` with blocks as usual.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "tapenade"
```

That's all.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
