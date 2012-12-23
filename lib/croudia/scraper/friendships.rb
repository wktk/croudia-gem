module Croudia
  class Scraper
    module Friendships
      def follow(username)
        require_login
        post('/follows/target_follow',
          :target_user_name => username,
          :follow_action => 'enable',
        )
      end

      def unfollow(username)
        require_login
        post('/follows/target_follow',
          :target_user_name => username,
          :follow_action => 'diable', # Yes, it is!
        )
      end

      def following(username=nil, params={})
        username = @current_user.username unless username
        Parser.user_list(get("/follows/following/#{username}", params))
      end
      alias followings following

      def follower(username=nil, params={})
        username = @current_user.username unless username
        Parser.user_list(get("/follows/follower/#{username}", params))
      end
      alias followers follower
    end
  end
end
