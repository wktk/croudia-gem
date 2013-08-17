require 'croudia/creatable'
require 'croudia/identity'

module Croudia
  class User < Croudia::Identity
    include Croudia::Creatable

    KEYS = [
      :id_str,
      :blocking,
      :connections,
      :description,
      :favorites_count,
      :follow_request_sent,
      :followed_by,
      :following,
      :followers_count,
      :friends_count,
      :location,
      :name,
      :profile_image_url_https,
      :protected,
      :screen_name,
      :statuses_count,
      :url,
    ]

    attr_reader(*KEYS)
  end
end
