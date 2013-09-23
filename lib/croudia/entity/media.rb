require 'croudia/base'

module Croudia
  module Entity
    class Media < Croudia::Base
      attr_reader(
        :media_url_https,
        :type
      )
    end
  end
end
