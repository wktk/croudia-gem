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

        resp = get('/users/show.json', params)
        Croudia::User.new(resp)
      end
    end
  end
end
