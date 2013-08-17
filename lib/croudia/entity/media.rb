require 'croudia/base'

module Croudia
  module Entity
    class Media < Croudia::Base
      KEYS = [
        :media_url_https,
        :type,
      ]
      attr_reader(*KEYS)
    end
  end
end
