require 'croudia/error'
require 'faraday'

module Croudia
  module Response
    class RaiseError < Faraday::Response::Middleware
      def on_complete(env)
        error_class = case env[:status]
        when 400
          Croudia::Error::BadRequest
        when 401
          Croudia::Error::Unauthorized
        when 403
          Croudia::Error::Forbidden
        when 404
          Croudia::Error::NotFound
        when 400 .. 499
          Croudia::Error::ClientError
        when 502
          Croudia::Error::BadGateway
        when 503
          Croudia::Error::Unavailable
        when 500 .. 599
          Croudia::Error::ServerError
        else
          return
        end

        raise error_class.new(env)
      end
    end
  end
end

Faraday.register_middleware :response,
  raise_error: lambda { Croudia::Response::RaiseError }
