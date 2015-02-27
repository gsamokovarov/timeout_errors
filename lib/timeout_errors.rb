require "timeout_errors/version"
require "net/http"

module TimeoutErrors
  extend self

  def include_error(error)
    errors << error
  end

  def ===(other)
    errors.any? { |error| error === other }
  end

  private

  def errors
    @@errors ||= []
  end
end

[
  EOFError,
  Errno::ECONNREFUSED,
  Errno::ECONNRESET,
  Errno::EHOSTUNREACH,
  Errno::EINVAL,
  Errno::ENETUNREACH,
  Errno::EPIPE,
  Errno::ETIMEDOUT,
  Net::HTTPBadResponse,
  Net::HTTPHeaderSyntaxError,
  Net::ProtocolError,
  SocketError,
  Timeout::Error,
].each(&TimeoutErrors.method(:include_error))
