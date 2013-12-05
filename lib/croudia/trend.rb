require 'croudia/base'

module Croudia
  class Trend < Base
    attr_reader(
      :name,
      :promoted_content,
      :query
    )

    alias to_s name
  end
end
