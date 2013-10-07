require 'croudia/status'

module Croudia
  module API
    module Timelines
      # Public Timeline
      #
      # @see https://developer.croudia.com/docs/01_statuses_public_timeline
      # @param [Hash] params Additional query parameters
      # @option params [String, Integer] :count Number of statuses in the response
      # @option params [String] :include_entities Set false to exclude entities
      # @option params [String, Integer] :max_id Paging parameter
      # @option params [String, Integer] :since_id Paging parameter
      # @option params [String] :trim_user Set true to return compact user objects
      # @return [Array<Croudia::Status>]
      def public_timeline(params={})
        resp = get('/statuses/public_timeline.json', params)
        objects(Croudia::Status, resp)
      end

      # Home Timeline
      #
      # @see https://developer.croudia.com/docs/02_statuses_home_timeline
      # @param [Hash] params Additional query parameters
      # @option params [String, Integer] :count Number of statuses in the response
      # @option params [String] :include_entities Set false to exclude entities
      # @option params [String, Integer] :max_id Paging parameter
      # @option params [String, Integer] :since_id Paging parameter
      # @option params [String] :trim_user Set true to return compact user objects
      # @return [Array<Croudia::Status>]
      def home_timeline(params={})
        resp = get('/statuses/home_timeline.json', params)
        objects(Croudia::Status, resp)
      end

      # User Timeline
      #
      # @see https://developer.croudia.com/docs/03_statuses_user_timeline
      # @overload user_timeline(user, params={})
      #   @param [String, Integer, Croudia::User] user
      #   @param [Hash] params Additional query parameters
      #   @option params [String, Integer] :count Number of statuses in the response
      #   @option params [String] :include_entities Set false to exclude entities
      #   @option params [String, Integer] :max_id Paging parameter
      #   @option params [String, Integer] :since_id Paging parameter
      #   @option params [String] :trim_user Set true to return compact user objects
      # @overload user_timeline(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String, Integer] :count Number of statuses in the response
      #   @option params [String] :include_entities Set false to exclude entities
      #   @option params [String, Integer] :max_id Paging parameter
      #   @option params [String] :screen_name Screen name of the user
      #   @option params [String, Integer] :since_id Paging parameter
      #   @option params [String] :trim_user Set true to return compact user objects
      #   @option params [String, Integer] :user_id ID of the user
      # @return [Array<Croudia::Status>]
      def user_timeline(user, params={})
        merge_user!(params, user)
        resp = get('/statuses/user_timeline.json', params)
        objects(Croudia::Status, resp)
      end

      # Mentions
      #
      # @see https://developer.croudia.com/docs/04_statuses_mentions
      # @param [Hash] params Additional query parameters
      # @option params [String, Integer] :count Number of statuses in the response
      # @option params [String] :include_entities Set false to exclude entities
      # @option params [String, Integer] :max_id Paging parameter
      # @option params [String, Integer] :since_id Paging parameter
      # @option params [String] :trim_user Set true to return compact user objects
      # @return [Array<Croudia::Status>]
      def mentions(params={})
        resp = get('/statuses/mentions.json', params)
        objects(Croudia::Status, resp)
      end
      alias mentions_timeline mentions
    end
  end
end
