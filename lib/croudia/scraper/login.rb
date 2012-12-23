module Croudia
  class Scraper
    module Login
      def login(username, password)
        get('/')
        params = {
          :username => username,
          :password => password,
          :auto_login => 'on',
        }
        post('/', params)
        raise ArgumentError, 'Wrong ID or password' if not logged_in?
      end
      alias login! login

      def logout
        require_login
        post('/login/logout', :method_name => 'logout')
        @current_user = nil
        @logged_in = false
      end
      alias logout! logout

      def logged_in?(force=false)
        @logged_in = nil if force
        @logged_in = @logged_in.nil? ? '/' != get('/').uri.path : @logged_in
      end
      alias logged_in logged_in?

      def logged_out?(force=false)
        !logged_in?(force)
      end
      alias logged_out logged_out?

      def require_login
        raise 'Not logged in' if logged_out?
      end
    end
  end
end
