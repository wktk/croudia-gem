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

      def approve(username)
        require_login
        post('/follows/follow_approve',
          :target_user_name => username,
          :follow_action => 'approve',
        )
      end

      def refusal(username)
        require_login
        post('/follows/follow_refusal',
          :target_user_name => username,
          :follow_action => 'refusal',
        )
      end
      alias refuse refusal

      def block(username)
        require_login
        post('/blocks/setting',
          :target_user_name => username,
          :block_action => 'enable',
        )
      end

      def unblock(username)
        require_login
        post('/blocks/setting',
          :target_user_name => username,
          :block_action => 'diable', # Yes, it's diable
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

      def follow_request
        require_login
        Parser.user_list(get('/follows/follow_request'))
      end
      alias follow_requests follow_request
    end
  end
end
