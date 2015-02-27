# Timeout Errors

Catch all of them Net::HTTP timeout errors. Why? Because there are lots of
them.

## Install

Add this line to your application's Gemfile:

```ruby
gem 'timeout_errors'
```

## Play

Let's playing a game. You do a request. It times out. You try to guess which
error it timed out with. Here's how you win every time.

```ruby
require 'uri'
require 'timeout_errors'

begin
  uri = URI.parse("http://imsuresomeonewillregisterthatjusttotroll.me/")
  Net::HTTP.get_response(uri)
rescue TimeoutErrors => e
  puts "And the winner is: #{e.inspect}"
end
```

Now, imagine your favourite 3rd party HTTP client library, that uses `net/http`
under the hook invents yet another one of those pesky timeout errors. If you
play the game with that specific 3rd party library, you are quite likely to
loose. Here's how you can improve your chances:

```ruby
require 'best_http_client_ever_because_we_need_yet_another_one'
require 'timeout_errors'

TimeoutErrors.include_error(
  BestHttpClientEverBecauseWeNeedYetAnotherOne::YetAnotherTimeoutToSolveItAllError
)

begin
  BestHttpClientEverBecauseWeNeedYetAnotherOne.get(
    "http://imsuresomeonewillregisterthatjusttotroll.me/"
  )
rescue TimeoutErrors => e
  puts "Your favourite timeout error is: #{e.inspect}"
end
```

Quite useful, heh?

## Winners

Here's the list of errors caught by `TimeoutErrors` by default.

- `EOFError`
- `Errno::ECONNREFUSED`
- `Errno::ECONNRESET`
- `Errno::EHOSTUNREACH`
- `Errno::EINVAL`
- `Errno::ENETUNREACH`
- `Errno::EPIPE`
- `Errno::ETIMEDOUT`
- `Net::HTTPBadResponse`
- `Net::HTTPHeaderSyntaxError`
- `Net::ProtocolError`
- `SocketError`
- `Timeout::Error`

Note that you can fill this list during runtime with
`TimeoutErrors.include_error`.

## Why

There is a lot of previous art on this topic. Why create another one?

### [net_http_timeout_errors]

This library is a great choice. It uses standard Ruby interface and clearly
lists all the errors. However, I wanna catch them all with a single `rescue
ErrorMatcher` clause. Which leads us to [net_http_exception_fix].

### [net_http_exception_fix]

[net_http_exception_fix] is a hotfix to give those common exceptions that pop
up from Net:HTTP usage a shared parent exception class. This is the interface I
like, however it is achieved through polluting builtin' errors ancestor chain.

## How

Instead of introducing extra interface, or monkey patching existing errors,
this library exploits a fun little fact about Ruby's exception handling. Errors
listed on the `rescue` clause are matched with the case (`===`) operator.

## Credits

Thanks to the authors and contributors of [net_http_timeout_errors] and
[net_http_exception_fix].

[net_http_timeout_errors]: https://github.com/barsoom/net_http_timeout_errors
[net_http_exception_fix]: https://github.com/edward/net_http_exception_fix
