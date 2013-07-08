require 'croudia/base'

module Croudia
  class AccessToken < Croudia::Base
    attr_reader :access_token, :refresh_token, :expires_in, :token_type
    alias :token :access_token

    def to_s
      access_token
    end
  end
end
