require 'croudia/base'
require 'croudia/search_metadata'
require 'croudia/status'

module Croudia
  class SearchResults < Croudia::Base
    attr_object_reader(
      search_metadata: Croudia::SearchMetadata,
      statuses: Array(Croudia::Status)
    )
  end
end
