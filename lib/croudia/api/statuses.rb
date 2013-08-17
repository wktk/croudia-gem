require 'croudia/status'

module Croudia
  module API
    module Statuses
      # Update status
      #
      # @param status [String] Status text
      # @param params [Hash] Additional params
      # @return status [Croudia::Status] Posted status
      def update(text, params={})
        merge_text!(params, text)

        resp = post('/statuses/update.json', params)
        Croudia::Status.new(resp)
      end

      # Update status with media
      #
      # @param status [String] Status text
      # @param media [File] Image to upload with
      # @return [Croudia::Status]
      def update_with_media(status, media={}, params={})
        merge_text!(params, status)
        merge_file!(params, media, :media)
        resp = post('/statuses/update_with_media.json', params)
        Croudia::Status.new(resp)
      end

      # Destroy a status
      #
      # @param status_id [String, Integer, Croudia::Status] Status to delete
      # @param params [Hash]
      # @return [Croudia::Status] Deleted status
      def destroy_status(status_id, params={})
        status_id = get_id(status_id)
        resp = post("/statuses/destroy/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end

      # Retrieve a status
      #
      # @param status_id [String, Integer, Croudia::Status]
      # @param params [Hash]
      # @return [Croudia::Status]
      def status(status_id, params={})
        status_id = get_id(status_id)
        resp = get("/statuses/show/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end

      # Spread a status
      #
      # @param status_id [String, Integer, Croudia::Status] Status to spread
      # @param params [Hash]
      # @return [Croudia::Status] My status including spreaded status
      def spread(status_id, params={})
        status_id = get_id(status_id)
        resp = post("/statuses/spread/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end
    end
  end
end
