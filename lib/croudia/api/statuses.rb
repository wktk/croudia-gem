require 'croudia/status'

module Croudia
  module API
    module Statuses
      # Update status
      #
      # @param status [String] Status text
      # @param params [Hash] Additional params
      # @return status [Croudia::Status] Posted status
      def update(status, params={})
        case status
        when String
          params[:status] ||= status
        when Hash
          params = status.merge(params)
        end

        resp = post('/statuses/update.json', params)
        Croudia::Status.new(resp)
      end

      # Destroy a status
      #
      # @param status_id [String, Integer, Croudia::Status] Status to delete
      # @param params [Hash]
      # @return [Croudia::Status] Deleted status
      def destroy_status(status_id, params={})
        case status_id
        when String, Integer
        when Croudia::Status
          status_id = status_id.id_str
        end

        post("/statuses/destroy/#{status_id}.json", params)
      end

      # Retrieve a status
      #
      # @param status_id [String, Integer, Croudia::Status]
      # @param params [Hash]
      # @return [Croudia::Status]
      def status(status_id, params={})
        case status_id
        when String, Integer
        when Croudia::Status
          status_id = status_id.id_str
        end

        resp = get("/statuses/show/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end

      # Spread a status
      #
      # @param status_id [String, Integer, Croudia::Status] Status to spread
      # @param params [Hash]
      # @return [Croudia::Status] My status including spreaded status
      def spread(status_id, params={})
        case status_id
        when String, Integer
        when Croudia::Status
          status_id = status_id.id_str
        end

        resp = post("/statuses/spread/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end
    end
  end
end
