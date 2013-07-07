require 'croudia/default'

module Croudia
  module Configurable
    attr_writer :client_secret, :access_token
    attr_accessor :client_id, :endpoint, :connection_options, :middleware

    class << self
      def keys
        @keys ||= [
          :endpoint,
          :connection_options,
          :middleware,
          :client_id,
          :client_secret,
          :access_token,
        ]
      end
    end

    def configure
      yield self
      self
    end

    def reset!
      Croudia::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Croudia::Default.options[key])
      end
    end
    alias setup reset!

    def options
      Hash[Croudia::Configurable.keys.map do |key|
        [key, instance_variable_get(:"@#{key}")]
      end]
    end
  end
end
