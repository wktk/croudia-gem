require 'faraday'
require 'json'

module Croudia
  module Response
    class ParseJSON < Faraday::Response::Middleware
      def on_complete(env)
        return unless env[:response_headers]['content-type'].to_s.include?('json')

        case env[:body]
        when /\A\s*\z/, nil
          env[:body] = nil
        else
          env[:body] = JSON.parse(env[:body])
        end
      rescue JSON::ParserError => e
        env[:status] == 200 ? raise(e) : env[:body] = nil
      end
    end
  end
end

Faraday.register_middleware :response,
  parse_json: Croudia::Response::ParseJSON
