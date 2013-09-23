require 'croudia/base'
require 'croudia/entity/media'

module Croudia
  class Entities < Croudia::Base
    attr_object_reader(
      media: Croudia::Entity::Media
    )
  end
end
