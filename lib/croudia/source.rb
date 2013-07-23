require 'croudia/base'

module Croudia
  class Source < Croudia::Base

    KEYS = [
      :name,
      :url,
    ]

    attr_reader(*KEYS)
    alias to_s name

    def ==(other)
      super || (other.is_a?(Croudia::Source) &&
        name == other.name && url == other.url)
    end

  end
end
