require 'croudia/identity'

module Croudia
  class Voice < Croudia::Identity
    attr_reader :user, :voice_desc, :spreaded_count, :favorited_count, :time
    alias from_user user
    alias text voice_desc
    alias description voice_desc
    alias desc voice_desc
    alias spread_count spreaded_count
    alias favorite_count favorited_count

    def to_s
      "@#{user.username}: #{voice_desc}"
    end

    def to_i
      @id.to_i
    end
  end
end
