# Tapenade

Want to call a method and return `self` instead of normal return ? Just prefix it with `tap_` !

## Examples

```ruby
# Without any tap method:
def update_user
  user = User.find(param[:id])
  user.update!(user_params)
  return user
end

# With Ruby's tap
def update_user
  User.find(param[:id]).tap { |user| user.update!(user_params) }
end

# With Tapenade:
def update_user
  User.find(param[:id]).tap_update!(user_params)
end
```

Examples are using Rails models but it works with any method on any object.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "tapenade"
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
