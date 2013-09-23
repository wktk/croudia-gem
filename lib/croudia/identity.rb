require 'croudia/base'

module Croudia
  class Identity < Croudia::Base
    attr_reader(
      :id,
      :id_str
    )

    def initialize(*)
      super
      raise ArgumentError, 'argument must have an "id" key' unless id
      @attrs['id_str'] ||= id.to_s
    end

    # @param other [Croudia::Identity]
    # @return [Boolean]
    def ==(other)
      super || self.class == other.class && id == other.id
    end
  end
end
