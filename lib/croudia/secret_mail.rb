require 'croudia/identity'
require 'croudia/creatable'

module Croudia
  class SecretMail < Croudia::Identity
    include Croudia::Creatable

    attr_reader(
      :id_str,
      :recipient,
      :recipient_id,
      :recipient_screen_name,
      :sender,
      :sender_id,
      :sender_screen_name,
      :text
    )

    def initialize(attrs)
      recipient = attrs.delete('recipient')
      sender = attrs.delete('sender')
      super(attrs)
      @attrs['recipient'] = Croudia::User.new(recipient) if recipient
      @attrs['sender'] = Croudia::User.new(sender) if sender
    end
  end
end
