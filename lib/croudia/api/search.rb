require 'croudia/search_results'
require 'croudia/user'

module Croudia
  module API
    module Search
      # Search for statuses
      #
      # @param q [String] Search query
      # @param params [Hash] Optional params
      # @return [Croudia::SearchResults]
      def search(q, params={})
        merge_query!(params, q)
        resp = get('/search/voices.json', params)
        Croudia::SearchResults.new(resp)
      end

      # Search for users
      #
      # @param q [String] Search query
      # @param params [Hash] Optional params
      # @return [Array<Croudia::User>]
      def search_user(q, params={})
        merge_query!(params, q)
        resp = get('/users/search.json', params)
        objects(Croudia::User, resp)
      end
    end
  end
end
