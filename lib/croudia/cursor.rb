require 'croudia/base'

module Croudia
  class Cursor < Croudia::Base
    attr_reader(
      :next_cursor,
      :next_cursor_str,
      :previous_cursor,
      :previous_cursor_str
    )

    def initialize(key, klass, attrs)
      if klass.is_a?(Class)
        attrs[key.to_s].map! { |element| klass.new(element) }
      end
      singleton_class.attr_reader(key)
      super(attrs)
    end

    def first?
      previous_cursor.zero?
    end

    def last?
      next_cursor.zero?
    end
  end
end
