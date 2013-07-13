require 'croudia/user'

module Croudia
  module API
    module Friendships
      # Follow a user
      #
      # @param user [String. Integer, Croudia::User]
      # @param params [Hash] Optional params
      # @return [Croudia::User] Followed user
      def follow(user, params={})
        case user
        when Hash
          params.merge!(user)
        when String
          params[:screen_name] = user
        when Integer
          params[:user_id] = user
        when Croudia::User
          params[:user_id] = user.id_str
        else
          raise ArgumentError, 'user must be a String, Integer or User'
        end

        resp = post('/friendships/create.json', params)
        Croudia::User.new(resp)
      end

      # Unfollow a user
      #
      # @param user [String, Integer, Croudia::User]
      # @param params
      # @return [Croudia::User] Unfollowed user
      def unfollow(user, params={})
        case user
        when Hash
          params.merge!(user)
        when String
          params[:screen_name] = user
        when Integer
          params[:user_id] = user
        when Croudia::user
          params[:user_id] = user.id_str
        else
          raise ArgumentError, 'user must be a String, Integer or User'
        end

        resp = post('/friendships/destroy.json', params)
        Croudia::User.new(resp)
      end
    end
  end
end
