require 'croudia/client'
require 'croudia/configurable'
require 'croudia/version'

module Croudia
  class << self
    include Croudia::Configurable

    # Delegate to a Croudia::Client
    #
    # @return [Croudia::Client]
    def client
      if !@client || @client.hash != options.hash
        @client = Croudia::Client.new
      end
      @client
    end

    def respond_to?(*args)
      super || client.respond_to?(*args)
    end

  private

    def method_missing(name, *args, &block)
      return super unless client.respond_to?(name)
      client.send(name, *args, &block)
    end
  end
end

Croudia.setup
