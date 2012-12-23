module Croudia
  class Scraper
    module Users
      def current_user(force=false)
        require_login
        @current_user = nil if force
        @current_user ||= Parser.user_page(get('/users/redirect_user'))
      end
      alias verify_credentials current_user

      def user(username=nil, params={})
        if username
          Parser.user_page(get("/#{username}", params))
        else
          current_user
        end
      end
    end
  end
end
