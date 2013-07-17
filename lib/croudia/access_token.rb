require 'croudia/base'

module Croudia
  class AccessToken < Croudia::Base
    KEYS = [
      :access_token,
      :expires_in,
      :refresh_token,
      :token_type,
    ]

    attr_reader(*KEYS)

    alias :token :access_token

    def to_s
      access_token
    end
  end
end
