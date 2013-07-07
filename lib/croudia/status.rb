require 'croudia/creatable'
require 'croudia/identity'
require 'croudia/user'

module Croudia
  class Status < Croudia::Identity
    include Croudia::Creatable

    attr_reader :favorited, :favorite_count,
      :in_reply_to_screen_name, :in_reply_to_status_id_str,
      :in_reply_to_status_id, :in_reply_to_user_id_str,
      :in_reply_to_user_id, :spread_count,
      :play_spread, :play_spread_status, :reply_status, :source,
      :text, :user

    def initialize(attrs={})
      user = attrs.delete(:user)
      pss = attrs.delete(:play_spread_status)
      reply_status = attrs.delete(:reply_status)
      super(attrs)
      @attrs[:user] = Croudia::User.new(user) if user
      @attrs[:play_spread_status] = Croudia::Status.new(pss) if pss
      @attrs[:reply_status] = Croudia::Status.new(reply_status) if reply_status
    end
  end
end   
