require 'faraday'
require 'json'

module Croudia
  module Response
    class ParseJSON < Faraday::Response::Middleware
      def on_complete(env)
        case env[:body]
        when /\A\s*\z/, nil
          env[:body] = nil
        else
          env[:body] = JSON.parse(env[:body])
        end
      rescue JSON::ParserError => e
        raise e if env[:status] == 200
        env[:body] = nil
      end
    end
  end
end

Faraday.register_middleware :response,
  parse_json: Croudia::Response::ParseJSON
