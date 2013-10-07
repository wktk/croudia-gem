require 'croudia/access_token'

module Croudia
  module API
    module OAuth
      # Authorize URL
      #
      # @see https://developer.croudia.com/docs/oauth
      # @param [Hash] params Query parameters
      # @option params [String] :client_id (@client_id) OAuth client ID
      # @option params [String] :response_type ("code") OAuth response type
      # @option params [String] :state
      # @return [String] Authorize URL
      def authorize_url(params={})
        params[:client_id] ||= @client_id
        params[:response_type] ||= 'code'
        connection.build_url('/oauth/authorize', params).to_s
      end

      # Retrieve access_token
      #
      # @see https://developer.croudia.com/docs/oauth
      # @overload get_access_token(code, params={})
      #   @param [String] code Authorize code passed from user
      #   @param [Hash] params Additional query parameters
      #   @option params [String] :client_id (@client_id) OAuth client ID
      #   @option params [String] :client_secret (@client_secret) OAuth client secret
      #   @option params [String] :grant_type ("authorization_code") OAuth grant type
      # @overload get_access_token(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String] :client_id (@client_id) OAuth client ID
      #   @option params [String] :client_secret (@client_secret) OAuth client secret
      #   @option params [String] :code Code param passed from user
      #   @option params [String] :grant_type ("authorization_code") OAuth grant type
      # @return [Croudia::AccessToken] Access token
      def get_access_token(code, params={})
        case code
        when String, Integer
          params[:code] ||= code
        when Hash
          params = code.merge(params)
        end
        params[:client_id] ||= @client_id
        params[:client_secret] ||= @client_secret
        params[:grant_type] ||= 'authorization_code'
        resp = post('/oauth/token', params)
        Croudia::AccessToken.new(resp)
      end
    end
  end
end
