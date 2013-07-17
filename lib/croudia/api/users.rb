require 'croudia/user'

module Croudia
  module API
    module Users
      # Retrieve a user
      #
      # @param user [String, Integer, Croudia::User]
      # @param params [Hash] Optional params
      # @return [Croudia::User]
      def user(user, params={})
        merge_user!(params, user)
        resp = get('/users/show.json', params)
        Croudia::User.new(resp)
      end
    end
  end
end
