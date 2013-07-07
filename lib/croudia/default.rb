require 'faraday'
require 'faraday_middleware'
require 'croudia/configurable'

module Croudia
  module Default
    ENDPOINT = 'https://api.croudia.com' unless defined? Croudia::Default::ENDPOINT
    CONNECTION_OPTIONS = {
      headers: {
        accept: 'application/json',
        user_agent: "Croudia Ruby Gem/#{Croudia::VERSION}",
      },
      request: {
        open_timeout: 5,
        timeout: 10,
      },
      ssl: {
        verify: true,
      },
    } unless defined? Croudia::Default::CONNECTION_OPTIONS
    MIDDLEWARE = Faraday::Builder.new do |builder|
      builder.request :url_encoded

      builder.response :mashify
      builder.response :json
      builder.response :raise_error

      builder.adapter :net_http
    end unless defined? Croudia::Default::MIDDLEWARE

    class << self
      def options
        Hash[Croudia::Configurable.keys.map do |key|
          [key, __send__(key)]
        end]
      end

      def client_id
        ENV['CROUDIA_CLIENT_ID']
      end

      def client_secret
        ENV['CROUDIA_CLIENT_SECRET']
      end

      def access_token
        ENV['CROUDIA_ACCESS_TOKEN']
      end

      def endpoint
        ENDPOINT
      end

      def connection_options
        CONNECTION_OPTIONS
      end

      def middleware
        MIDDLEWARE
      end
    end
  end
end
