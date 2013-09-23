require 'croudia/base'

module Croudia
  class AccessToken < Croudia::Base
    attr_reader(
      :access_token,
      :expires_in,
      :refresh_token,
      :token_type
    )

    alias :token :access_token
    alias :to_s :access_token
  end
end
