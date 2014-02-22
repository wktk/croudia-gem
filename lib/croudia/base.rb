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

      # @param [Hash] attrs { name: Class, name: Class, ... }
      def attr_object_reader(attrs)
        attrs.each_pair do |path, klass|
          path = [path] unless path.is_a?(Array)
          attr = path.join('_').to_sym

          define_method(path.last) do
            object = instance_variable_get("@#{attr}")

            unless object
              object_attrs = @attrs
              path.each { |p| object_attrs = object_attrs[p.to_s] }

              object = if object_attrs.nil?
                nil
              elsif klass.is_a?(Array)
                klass = klass.shift
                object_attrs.map { |o| klass.new(o) }
              else
                klass.new(object_attrs)
              end

              instance_variable_set("@#{attr}", object)
            end

            object
          end
        end
      end
    end

    # Initialize a new object
    #
    # @param [Hash] attrs
    # @return [Croudia::Base]
    def initialize(attrs = {})
      @attrs = attrs
    end

    # Fetch an attribute
    #
    # @param [String, Symobol] name
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

    def inspect
      "#<#{self.class} #{@attrs.inspect}>"
    end
  end
end
