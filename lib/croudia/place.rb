require 'croudia/base'

module Croudia
  class Place < Base
    attr_reader(
      :name,
      :woeid
    )
  end
end
