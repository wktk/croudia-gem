require 'croudia/status'

module Croudia
  module API
    module Statuses
      # Update status
      #
      # @see https://developer.croudia.com/docs/11_statuses_update
      # @overload update(status, params={})
      #   @param [String] status Status text
      #   @param [Hash] params Additional query parameters
      #   @option params [String, Integer] :in_reply_to_status_id
      #   @option params [String] :in_reply_with_quote Set true if quote
      #   @option params [String] :include_entities Set false to exclude entities
      #   @option params [String] :trim_user Set true to return compact user objects
      # @overload update(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String, Integer] :in_reply_to_status_id
      #   @option params [String] :in_reply_with_quote Set true if quote
      #   @option params [String] :include_entities Set false to exclude entities
      #   @option params [String] :status Status text
      #   @option params [String] :trim_user Set true to return compact user objects
      # @return [Croudia::Status] Posted status
      def update(status, params={})
        merge_text!(params, status)

        resp = post('/statuses/update.json', params)
        Croudia::Status.new(resp)
      end

      # Update status with media
      #
      # @see https://developer.croudia.com/docs/14_statuses_update_with_media
      # @note Currently only PNG, JPG, and GIF are supported
      # @overload update_with_media(status, media, params={})
      #   @param [String] status Status text
      #   @param [File, #to_io] media Image to upload with
      #   @option params [String, Integer] :in_reply_to_status_id
      #   @option params [String] :in_reply_with_quote Set true if quote
      #   @option params [String] :include_entities Set false to exclude entities
      #   @option params [String] :trim_user Set true to return compact user objects
      # @overload update_with_media(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String, Integer] :in_reply_to_status_id
      #   @option params [String] :in_reply_with_quote Set true if quote
      #   @option params [String] :include_entities Set false to exclude entities
      #   @option params [File, #to_io] media Image to upload with
      #   @option params [String] :status Status text
      #   @option params [String] :trim_user Set true to return compact user objects
      # @return [Croudia::Status]
      def update_with_media(status, media={}, params={})
        merge_text!(params, status)
        merge_file!(params, media, :media)
        resp = post('/statuses/update_with_media.json', params)
        Croudia::Status.new(resp)
      end

      # Destroy a status
      #
      # @see https://developer.croudia.com/docs/12_statuses_destroy
      # @param [String, Integer, Croudia::Status] status Status to delete
      # @param [Hash] params Additional query parameters
      # @option params [String] :include_entities Set false to exclude entities
      # @option params [String] :trim_user Set true to return compact user objects
      # @return [Croudia::Status] Deleted status
      def destroy_status(status, params={})
        status_id = get_id(status)
        resp = post("/statuses/destroy/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end

      # Retrieve a status
      #
      # @see https://developer.croudia.com/docs/13_statuses_show
      # @param [String, Integer, Croudia::Status] status Status to get
      # @param [Hash] params Additional query parameters
      # @option params [String] :include_entities Set false to exclude entities
      # @option params [String] :trim_user Set true to return compact user objects
      # @return [Croudia::Status]
      def status(status, params={})
        status_id = get_id(status)
        resp = get("/statuses/show/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end

      # Spread a status
      #
      # @see https://developer.croudia.com/docs/61_statuses_spread
      # @param [String, Integer, Croudia::Status] status Status to spread
      # @param [Hash] params Additional query parameters
      # @option params [String] :include_entities Set false to exclude entities
      # @option params [String] :trim_user Set true to return compact user objects
      # @return [Croudia::Status] My status including spreaded status
      def spread(status, params={})
        status_id = get_id(status)
        resp = post("/statuses/spread/#{status_id}.json", params)
        Croudia::Status.new(resp)
      end
    end
  end
end
