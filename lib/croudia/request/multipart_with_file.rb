require 'faraday'

module Croudia
  module Request
    class MultipartWithFile < Faraday::Middleware
      CONTENT_TYPE = 'Content-Type'

      def call(env)
        env[:body].each do |key, value|
          if value.respond_to?(:to_io)
            env[:body][key] = Faraday::UploadIO.new(value, mime_type(value.path))
          end
        end if env[:body].is_a?(::Hash)
        @app.call(env)
      end

    private

      def mime_type(path)
        case path
        when /\.jpe?g\z/i
          'image/jpeg'
        when /\.gif\z/i
          'image/gif'
        when /\.png\z/i
          'image/png'
        else
          'application/octet-stream'
        end
      end

    end
  end
end

Faraday.register_middleware :request,
  :multipart_with_file => lambda { Croudia::Request::MultipartWithFile }
