require 'croudia/identity'
require 'croudia/creatable'

module Croudia
  class SecretMail < Croudia::Identity
    include Croudia::Creatable

    attr_reader(
      :recipient_id,
      :recipient_screen_name,
      :sender_id,
      :sender_screen_name,
      :text
    )

    attr_object_reader(
      entities: Croudia::Entities,
      recipient: Croudia::User,
      sender: Croudia::User
    )
  end
end
