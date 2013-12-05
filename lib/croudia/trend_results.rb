require 'croudia/base'
require 'croudia/creatable'
require 'croudia/place'
require 'croudia/trend'
require 'time'

module Croudia
  class TrendResults < Base
    include Croudia::Creatable

    attr_object_reader(
      locations: Croudia::Place,
      trends: Array(Croudia::Trend)
    )

    alias location locations
    alias to_a trends

    # @return [Time]
    def as_of
      @as_of ||= Time.parse(@attrs['as_of'])
    end
  end
end
