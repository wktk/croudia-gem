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
        merge_user!(params, user)
        resp = post('/friendships/create.json', params)
        Croudia::User.new(resp)
      end

      # Unfollow a user
      #
      # @param user [String, Integer, Croudia::User]
      # @param params
      # @return [Croudia::User] Unfollowed user
      def unfollow(user, params={})
        merge_user!(params, user)
        resp = post('/friendships/destroy.json', params)
        Croudia::User.new(resp)
      end

      # Lookup Friendships
      #
      # @param *users [String, Integer, Croudia::User]
      # @param params [Hash]
      # @return [Array<Croudia::User>]
      def friendships(*args)
        merge_users!(params = {}, args)
        resp = get('/friendships/lookup.json', params)
        objects(Croudia::User, resp)
      end
    end
  end
end
