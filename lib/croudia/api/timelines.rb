require 'croudia/status'

module Croudia
  module API
    module Timelines
      # Public Timeline
      #
      # @param params [Hash] Additional params
      # @return [Array<Croudia::Status>]
      def public_timeline(params={})
        resp = get('/statuses/public_timeline.json', params)
        objectify_statuses(resp)
      end

      # Home Timeline
      #
      # @params params [Hash]
      # @return [Array<Croudia::Status>]
      def home_timeline(params={})
        resp = get('/statuses/home_timeline.json', params)
        objectify_statuses(resp)
      end

      # User Timeline
      #
      # @param user [String, Integer, Croudia::User]
      # @param params [Hash]
      # @return [Array<Croudia::Status>
      def user_timeline(user, params={})
        merge_user!(params, user)
        resp = get('/statuses/user_timeline.json', params)
        objectify_statuses(resp)
      end

      def mentions(params={})
        resp = get('/statuses/mentions.json', params)
        objectify_statuses(resp)
      end
      alias mentions_timeline mentions
    end
  end
end
