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
        case user
        when String
          params[:screen_name] ||= user
        when Integer
          params[:user_id] ||= user
        when Croudia::User
          params[:user_id] ||= user.id_str
        when Hash
          params = user.merge(params)
        end

        resp = get('/statuses/user_timeline.json', params)
        objectify_statuses(resp)
      end

      def mentions(params={})
        resp = get('/statuses/mentions.json', params)
        objectify_statuses(resp)
      end
      alias mentions_timeline mentions

    private
      def objectify_statuses(statuses)
        statuses.map { |status| Croudia::Status.new(status) }
      end
    end
  end
end
