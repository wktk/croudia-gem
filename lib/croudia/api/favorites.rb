require 'croudia/status'

module Croudia
  module API
    module Favorites
      # List of favorited statuses
      #
      # @param params [Hash]
      # @return [Array<Croudia::Status>]
      def favorites(params={})
        resp = get('/favorites.json', params)
        objects(Croudia::Status, resp)
      end

      # Favorite a status
      #
      # @param status_id [String, Integer, Croudia::Status]
      # @param params [Hash]
      # @return [Croudia::Status] Favorited status
      def favorite(status_id, params={})
        status_id = get_id(status_id)
        resp = post("/favorites/create/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end

      # Unfavorite a status
      #
      # @param status_id [String, Integer, Croudia::Status]
      # @param params [Hash]
      # @return [Croudia::Status] Unfavorited status
      def unfavorite(status_id, params={})
        status_id = get_id(status_id)
        resp = delete("/favorites/destroy/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end
    end
  end
end
