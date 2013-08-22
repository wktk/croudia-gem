require 'faraday'
require 'faraday_middleware'
require 'croudia/configurable'
require 'croudia/request/multipart_with_file'
require 'croudia/request/raise_error'
require 'croudia/response/parse_json'
require 'croudia/response/raise_error'
require 'croudia/version'

module Croudia
  module Default
    ENDPOINT = 'https://api.croudia.com' unless defined? Croudia::Default::ENDPOINT
    CONNECTION_OPTIONS = {
      headers: {
        accept: 'application/json',
        user_agent: "Croudia Ruby Gem/#{Croudia::VERSION}",
      },
      request: {
        open_timeout: 10,
        timeout: 30,
      },
      ssl: {
        verify: true,
      },
    } unless defined? Croudia::Default::CONNECTION_OPTIONS
    MIDDLEWARE = Faraday::Builder.new do |builder|
      builder.request :multipart_with_file
      builder.request :multipart
      builder.request :url_encoded
      builder.request :raise_error

      builder.response :raise_error
      builder.response :parse_json

      builder.adapter Faraday.default_adapter
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
