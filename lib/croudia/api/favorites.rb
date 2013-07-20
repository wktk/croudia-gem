require 'croudia/status'

module Croudia
  module API
    module Favorites
      # List of favorited statuses
      #
      # @param user [String]
      # @param params [Hash]
      # @return [Array<Croudia::Status>]
      def favorites(user={}, params={})
        resp = case user
        when Hash
          params.merge!(user)
          get('/favorites.json', params)
        else
          get("/favorites/#{user}.json", params)
        end

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
