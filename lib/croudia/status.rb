require 'croudia/creatable'
require 'croudia/entities'
require 'croudia/identity'
require 'croudia/source'
require 'croudia/user'

module Croudia
  class Status < Croudia::Identity
    include Croudia::Creatable

    attr_reader(
      :favorited,
      :favorited_count,
      :in_reply_to_screen_name,
      :in_reply_to_status_id,
      :in_reply_to_status_id_str,
      :in_reply_to_user_id, 
      :in_reply_to_user_id_str,
      :spread, 
      :spread_count, 
      :text,
    )

    attr_object_reader(
      entities: Croudia::Entities,
      reply_status: Croudia::Status,
      spread_status: Croudia::Status,
      source: Croudia::Source,
      user: Croudia::User
    )
  end
end 
