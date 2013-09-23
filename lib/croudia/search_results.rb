require 'croudia/base'
require 'croudia/search_metadata'
require 'croudia/status'

module Croudia
  class SearchResults < Croudia::Base
    attr_reader(
      :search_metadata,
      :statuses
    )

    def initialize(attrs)
      statuses = attrs.delete('statuses')
      metadata = attrs.delete('search_metadata')
      attrs['statuses'] = statuses.map { |s| Croudia::Status.new(s) }
      attrs['search_metadata'] = Croudia::SearchMetadata.new(metadata)
      super(attrs)
    end
  end
end
