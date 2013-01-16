require 'croudia/identity'

module Croudia
  class User < Croudia::Identity
    attr_reader :username, :nickname, :avatar, :self_introduction,
      :voices_count, :following_count, :followers_count, :album_count,
      :position, :user_url, :spreadia, :favodia,
      :following, :followed_by
    alias handle username
    alias screen_name username
    alias user_name username
    alias name nickname
    alias profile_image avatar
    alias description self_introduction
    alias voice_count voices_count
    alias statuses_count voices_count
    alias status_count voices_count
    alias updates_count voices_count
    alias update_count voices_count
    alias followings_count following_count
    alias friends_count following_count
    alias friend_count following_count
    alias follower_count followers_count
    alias location position
    alias url user_url
    alias favorited_count favodia
    alias favourited_count favodia
    alias spreaded_count spreadia
    alias following? following
    alias followed_by? followed_by

    def initialize(*args)
      super
      @id = username
      @spreadia = spreadia.to_i if spreadia
      @favodia = favodia.to_i if favodia
    end

    def to_s
      username
    end
  end
end
