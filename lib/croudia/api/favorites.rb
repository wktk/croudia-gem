require 'croudia/status'

module Croudia
  module API
    module Favorites
      # List of favorited statuses
      #
      # @see https://developer.croudia.com/docs/51_favorites
      # @param [Hash] params Additional query parameters
      # @option params [String, Integer] :count Number of statuses in the response
      # @option params [String] :include_entities Set false to exclude entities
      # @option params [String, Integer] :max_id Paging parameter
      # @option params [String, Integer] :since_id Paging parameter
      # @return [Array<Croudia::Status>]
      def favorites(params={})
        resp = get('/favorites.json', params)
        objects(Croudia::Status, resp)
      end

      # Favorite a status
      #
      # @see https://developer.croudia.com/docs/52_favorites_create
      # @param [String, Integer, Croudia::Status] status_id ID of the status to favorite
      # @param [Hash] params Additional query parameters
      # @option params [String] :include_entities Set false to exclude entities
      # @return [Croudia::Status] Favorited status
      def favorite(status_id, params={})
        status_id = get_id(status_id)
        resp = post("/favorites/create/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end

      # Unfavorite a status
      #
      # @see https://developer.croudia.com/docs/53_favorites_destroy
      # @param [String, Integer, Croudia::Status] status_id ID of the status to unfavorite
      # @param [Hash] params Additional query parameters
      # @option params [String] :include_entities Set false to exclude entities
      # @return [Croudia::Status] Unfavorited status
      def unfavorite(status_id, params={})
        status_id = get_id(status_id)
        resp = delete("/favorites/destroy/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end
    end
  end
end
