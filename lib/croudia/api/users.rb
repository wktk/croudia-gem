require 'croudia/user'

module Croudia
  module API
    module Users
      # Retrieve a user
      #
      # @see https://developer.croudia.com/docs/31_users_show
      # @overload user(user, params={})
      #   @param [String, Integer, Croudia::User] user
      #   @param [Hash] params Additional query parameters
      # @overload user(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String] :screen_name Screen name of the user
      #   @option params [String, Integer] :user_id ID of the user
      # @return [Croudia::User]
      def user(user, params={})
        merge_user!(params, user)
        resp = get('/users/show.json', params)
        Croudia::User.new(resp)
      end

      # Lookup Users
      #
      # @see https://developer.croudia.com/docs/32_users_lookup
      # @overload users(*users, params={})
      #   @param [String, Integer, Croudia::User] users
      #   @param [Hash] params Additional query parameters
      # @overload users(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String] :screen_name Comma-separated screen names
      #   @option params [String[ :user_id Comma-separated user IDs
      # @return [Array<Croudia::User>]
      def users(*args)
        merge_users!(params = {}, args)
        resp = get('/users/lookup.json', params)
        objects(Croudia::User, resp)
      end
    end
  end
end
