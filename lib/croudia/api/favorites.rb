require 'croudia/status'

module Croudia
  module API
    module Favorites
      # Favorite a status
      #
      # @param status_id [String, Integer, Croudia::Status]
      # @param params [Hash]
      # @return [Croudia::Status] Favorited status
      def favorite(status_id, params={})
        case status_id
        when String, Integer
        when Croudia::Status
          status_id = status_id.id_str
        else
          raise ArgumentError, 'status_id is invalid'
        end

        resp = post("/favorites/create/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end

      # Unfavorite a status
      #
      # @param status_id [String, Integer, Croudia::Status]
      # @param params [Hash]
      # @return [Croudia::Status] Unfavorited status
      def unfavorite(status_id, params={})
        case status_id
        when String, Integer
        when Croudia::Status
          status_id = status_id.id_str
        else
          raise ArgumentError, 'status_id is invalid'
        end
        
        resp = delete("/favorites/destroy/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end
    end
  end
end
