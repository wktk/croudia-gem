require 'time'

module Croudia
  module Creatable
    def created_at
      @created_at ||= Time.parse(@attrs['created_at'])
    end
  end
end
