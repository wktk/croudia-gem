require 'croudia/creatable'
require 'croudia/identity'

module Croudia
  class User < Croudia::Identity
    include Croudia::Creatable

    attr_reader :description, :favorites_count, :follow_request_sent,
      :followers_count, :fruends_count, :location, :name, :profile_image_url_https,
      :screen_name, :statuses_count, :url
  end
end
