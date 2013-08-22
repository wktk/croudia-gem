module Croudia
  class Error < StandardError

    # Error connecting to server
    class NetworkError < Error
      attr_reader :wrapped_exception

      def initialize(e)
        @wrapped_exception = e
        super(e.respond_to?(:message) ? e.message : e.to_s)
      end

      def backtrace
        if @wrapped_exception.respond_to?(:backtrace)
          @wrapped_exception.backtrace
        else
          super
        end
      end
    end

    class Timeout < NetworkError; end

    # Error connected to server
    class ConnectionError < Error
      attr_reader :code, :env, :error

      def initialize(env)
        @code = env[:status]
        @error = env[:body]['error'] rescue nil
        @env = env
        super(@error)
      end
    end

    # 4xx: Client Errors
    class ClientError < ConnectionError; end
    class BadRequest < ClientError; end
    class Unauthorized < ClientError; end
    class Forbidden < ClientError; end
    class NotFound < ClientError; end

    # 5xx: Server Errors
    class ServerError < ConnectionError; end
    class BadGateway < ServerError; end
    class Unavailable < ServerError; end
  end
end
