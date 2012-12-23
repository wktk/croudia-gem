module Croudia
  class Identity
    attr_reader :id, :time
    alias id_str id
    alias created_at time

    def initialize(attrs)
      attrs.keys.each do |key|
        if 'time' == key.to_s && !attrs[key].is_a?(Time)
          if /^\d+$/ =~ attrs[key]
            attrs[key] = Time.at(attrs[key].to_i)
          else
            attrs[key] = Time.new(*attrs[key].split(/\D/))
          end
        elsif /_count$/ =~ key.to_s
          attrs[key] = attrs[key].to_i
        end

        instance_variable_set(:"@#{key}", attrs[key])
      end
    end

    def ==(other)
      super || self.class == other.class && @id == other.id
    end

    def [](name)
      instance_variable_get(:"@#{name}")
    end

    def id
      @id
    end

    def method_missing(name, *args)
      self[name]
    end
  end
end
