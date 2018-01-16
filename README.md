# Mattermost

A rewrite of Mattermost-Ruby to be more elegant. And it's kind of cool.

## Notes

This is for v4 and forward. For v3, please use the original Mattermost-Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mattermost'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mattermost

## Usage

Don't use this yet. But it requires Mattermost version 4.

## Authentication

You'll want to create a user that has some system-wide roles within Mattermost.

    Mattermost.configure do |c|
      c.server = 'great-company.com'
      c.protocol = 'https'
      c.username = 'joshmn'
      c.password = 'password'
    end
    
    Mattermost.connect!

Without calling `connect!` you won't have the headers required to make the API calls, so call it somewhere once.

## Conventions

Inspired by the Active Record pattern, and Action Dispatch routes (member/collection), you can,

    User.find(user_id).teams

to get a User's teams.

Or, 

    User.create(mattermost_params)

to create a user.

All the corresponding methods are defined inside lib/mattermost/resources. Of note,

* Methods that have an `as` of `self` are class-level methods, and `member` are instance-level methods.
* The `args` option allows this client to map the passed arguments to a variable for usage in the HTTP request (`body` does the same thing, but for the body of the request)
* If an `endpoint` option has `:variable`, that's indicative of needing to pass an argument to the method.

