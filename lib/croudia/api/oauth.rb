require 'croudia/access_token'

module Croudia
  module API
    module OAuth
      # Authorize URL
      #
      # @return authorize_url [String]
      def authorize_url(params={})
        params[:client_id] ||= @client_id
        params[:response_type] ||= 'code'
        connection.build_url('/oauth/authorize', params).to_s.sub(/^https/, 'http')
      end

      # Retrieve access_token
      #
      # @param code [String] Authorize code passed from user
      # @params params [Hash] Additional params
      # @return access_token [Hash]
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
