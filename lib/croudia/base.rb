module Croudia
  class Base
    class << self
      def attr_reader(*attrs)
        attrs.each do |attr|
          define_method(attr) do
            @attrs[attr.to_s] || @attrs[attr.to_sym]
          end
        end
      end
    end

    # Initialize a new object
    #
    # @param attrs [Hash]
    # @return [Croudia::Base]
    def initialize(attrs = {})
      @attrs = attrs || {}
    end

    # Fetch an attribute
    #
    # @param name [String, Symobol]
    def [](name)
      __send__(name.to_sym)
    rescue NoMethodError
      nil
    end
    
    # @return [Hash]
    def attrs
      @attrs
    end
    alias to_h attrs
    alias to_hash attrs
  end
end
