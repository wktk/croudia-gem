require 'time'

module Croudia
  module Creatable
    # @return [Time]
    def created_at
      @created_at ||= Time.parse(@attrs['created_at'])
    end
  end
end
