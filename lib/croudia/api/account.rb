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

      # Update profile image
      #
      # @param image [File] New profile image
      # @param params [Hash]
      # @return [Croudia::User] Authenticated user object with new image
      def update_profile_image(image, params={})
        merge_file!(params, image, :image)
        resp = post('/account/update_profile_image.json', params)
        Croudia::User.new(resp)
      end

      # Update profile
      #
      # @param params [Hash]
      # @return [Croudia::User] Updated profile
      def update_profile(params)
        resp = post('/account/update_profile.json', params)
        Croudia::User.new(resp)
      end
    end
  end
end
