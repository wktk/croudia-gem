require 'croudia/creatable'
require 'croudia/identity'

module Croudia
  class User < Croudia::Identity
    include Croudia::Creatable

    KEYS = [
      :id_str,
      :connections,
      :description,
      :favorites_count,
      :follow_request_sent,
      :followers_count,
      :friends_count,
      :location,
      :name,
      :profile_image_url_https,
      :screen_name,
      :statuses_count,
      :url,
    ]

    attr_reader(*KEYS)
  end
end
