require 'croudia/base'
require 'croudia/entity/media'

module Croudia
  class Entities < Croudia::Base
    attr_reader(
      :media
    )

    def initialize(attrs)
      media = attrs.delete('media')
      super(attrs)
      @attrs['media'] = Croudia::Entity::Media.new(media) if media
    end
  end
end
