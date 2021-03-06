require 'croudia/base'

module Croudia
  class SearchMetadata < Croudia::Base
    attr_reader(
      :completed_in,
      :count,
      :max_id,
      :max_id_str,
      :next_results,
      :query,
      :refresh_url,
      :since_id,
      :since_ids_str
    )
  end
end
