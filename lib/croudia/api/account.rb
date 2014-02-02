require 'croudia/user'

module Croudia
  module API
    module Account
      # Retrieve the Authenticated User
      #
      # @see https://developer.croudia.com/docs/35_account_verify_credentials
      # @param [Hash] params Additional query parameterss
      # @return [Croudia::User] Current user's object
      def verify_credentials(params={})
        resp = get('/account/verify_credentials.json', params)
        Croudia::User.new(resp)
      end
      alias current_user verify_credentials

      # Update profile image
      #
      # @see https://developer.croudia.com/docs/36_account_update_profile_image
      # @overload update_profile_image(image, params={})
      #   @param [File] image New profile image
      #   @param [Hash] params Addtional query parameters
      # @overload update_profile_image(params={})
      #   @param [Hash] params Query parameters
      #   @option params [File] :image New profile image
      # @return [Croudia::User] Current user's object updated
      def update_profile_image(image, params={})
        merge_file!(params, image, :image)
        resp = post('/account/update_profile_image.json', params)
        Croudia::User.new(resp)
      end

      # Update cover image
      #
      # @see https://developer.croudia.com/docs/39_account_update_cover_image
      # @overload update_cover_image(image, params={})
      #   @param [File] image New cover image
      #   @param [Hash] params Addtional query parameters
      # @overload update_cover_image(params={})
      #   @param [Hash] params Query parameters
      #   @option params [File] :image New cover image
      # @return [Croudia::User] Current user's object updated
      def update_cover_image(image, params={})
        merge_file!(params, image, :image)
        resp = post('/account/update_cover_image.json', params)
        Croudia::User.new(resp)
      end

      # Update profile
      #
      # @see https://developer.croudia.com/docs/37_account_update_profile
      # @param [Hash] params Additional query parameters
      # @option params [String] :description Bio of the user
      # @option params [String] :location Geo location
      # @option params [String] :name Name of the user
      # @option params [String] :url URL
      # @return [Croudia::User] Updated profile
      def update_profile(params)
        resp = post('/account/update_profile.json', params)
        Croudia::User.new(resp)
      end
    end
  end
end
