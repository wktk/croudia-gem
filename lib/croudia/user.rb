require 'croudia/creatable'
require 'croudia/identity'

module Croudia
  class User < Croudia::Identity
    include Croudia::Creatable

    attr_reader(
      :blocking,
      :connections,
      :cover_image_url_https,
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
      :url
    )
  end
end
