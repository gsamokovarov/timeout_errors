$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require "minitest/autorun"
require "timeout_errors"

class TimeoutErrorsTest < MiniTest::Test
  def test_catches_the_default_list_of_errors
    default_errors.each(&method(:assert_catches))
  end

  def test_includes_custom_errors
    custom_error = Class.new(StandardError)
    TimeoutErrors.include_error(custom_error)

    assert_catches(custom_error)
  end

  private

  def default_errors
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
    ]
  end

  def assert_catches(error)
    begin
      raise error
    rescue TimeoutErrors
      # Great success!
    else
      flunk "Expected to catch #{error}, but didn't"
    end
  end
end
