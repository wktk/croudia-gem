require 'croudia/user'

module Croudia
  module API
    module Account
      # Retrieve the Authenticated User
      #
      # @params params [Hash] Additional params
      # @return [Croudia::User] Current user's object
      def verify_credentials(params={})
        resp = get('/account/verify_credentials.json', params)
        Croudia::User.new(resp)
      end
      alias current_user verify_credentials
    end
  end
end
