require 'croudia/error'
require 'faraday'

module Croudia
  module Request
    class RaiseError < Faraday::Middleware
      def call(env)
        @app.call(env)
      rescue Faraday::Error::TimeoutError => e
        raise Croudia::Error::Timeout.new(e)
      rescue Faraday::Error::ConnectionFailed => e
        raise Croudia::Error::ConnectionFailed.new(e)
      end
    end
  end
end

Faraday.register_middleware :request,
  raise_error: lambda { Croudia::Request::RaiseError }
