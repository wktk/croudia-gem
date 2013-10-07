require 'croudia/cursor'
require 'croudia/relationship'
require 'croudia/user'

module Croudia
  module API
    module Friendships
      # Follow a user
      #
      # @see https://developer.croudia.com/docs/41_friendships_create
      # @overload follow(user, params={})
      #   @param [String, Integer, Croudia::User] user User to follow
      #   @param [Hash] params Additional query parameters
      # @overload follow(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String] :screen_name Screen name of user to follow
      #   @option params [String, Integer] :user_id ID of user to follow
      # @return [Croudia::User] Followed user
      def follow(user, params={})
        merge_user!(params, user)
        resp = post('/friendships/create.json', params)
        Croudia::User.new(resp)
      end

      # Unfollow a user
      #
      # @see https://developer.croudia.com/docs/42_friendships_destroy
      # @overload unfollow(user, params={})
      #   @param [String, Integer, Croudia::User] user User to unfollow
      #   @param [Hash] params Additional query parameters
      # @overload unfollow(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String] :screen_name Screen name of user to unfollow
      #   @option params [String, Integer] :user_id ID of user to unfollow
      # @return [Croudia::User] Unfollowed user
      def unfollow(user, params={})
        merge_user!(params, user)
        resp = post('/friendships/destroy.json', params)
        Croudia::User.new(resp)
      end

      # Show relationship between two users
      #
      # @see https://developer.croudia.com/docs/44_friendships_show
      # @overload friendship(source, target, params={})
      #   @param [String, Integer, Croudia::User] source Source of the relationship
      #   @param [String, Integer, Croudia::User] target Target of the relationship
      #   @param [Hash] params Additional query parameters
      # @overload friendship(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String, Integer] :source_id ID of the source user
      #   @option params [String] :source_screen_name Screen name of the source user
      #   @option params [String, Integer] :target_id ID of the target user
      #   @option params [String] :target_screen_name Screen name of the target user
      # @return [Croudia::Relationship]
      def friendship(source, target={}, params={})
        merge_user!(params, source, :source_screen_name, :source_id)
        merge_user!(params, target, :target_screen_name, :target_id)
        resp = get('/friendships/show.json', params)
        Croudia::Relationship.new(resp)
      end

      # Lookup friendships between the current user and others
      #
      # @see https://developer.croudia.com/docs/47_friendships_lookup
      # @overload friendships(*users, params={})
      #   @param [String, Integer, Croudia::User] users Users to lookup friendships to them
      #   @param [Hash] params Additional query parameters
      # @overload friendships(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String] :screen_name Comma-separated screen names
      #   @option paramn [String] :user_id Comma-separated user IDs
      # @return [Array<Croudia::User>]
      def friendships(*args)
        merge_users!(params = {}, args)
        resp = get('/friendships/lookup.json', params)
        objects(Croudia::User, resp)
      end

      # Friend ids of specified user
      #
      # @see https://developer.croudia.com/docs/48_friends_ids
      # @overload friend_ids(user=current_user, params={})
      #   @param [String, Integer, Croudia::User] user User to look up friends of
      #   @param [Hash] params Additional query parameters
      #   @option params [String, Integer] :cursor Cursor number, -1 to get the first page
      # @overload friend_ids(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String, Integer] :cursor Cursor number, -1 to get the first page
      #   @option params [String] :screen_name Screen name of the user to look up friends of
      #   @option params [String, Integer] :user_id ID of the user to look up friends of
      # @return [Croudia::Cursor<Integer>] Cursor object that contains friend ids
      def friend_ids(user=current_user, params={})
        merge_user!(params, user)
        resp = get('/friends/ids.json', params)
        Croudia::Cursor.new(:ids, nil, resp)
      end

      # Follower ids of specified user
      #
      # @see https://developer.croudia.com/docs/49_followers_ids
      # @overload follower_ids(user=current_user, params={})
      #   @param [String, Integer, Croudia::User] user User to look up followers of
      #   @param [Hash] params Additional query parameters
      #   @option params [String, Integer] :cursor Cursor number, -1 to get the first page
      # @overload follower_ids(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String, Integer] :cursor Cursor number, -1 to get the first page
      #   @option params [String] :screen_name Screen name of the user to look up followers of
      #   @option params [String, Integer] :user_id ID of the user to look up followers of
      # @return [Croudia::Cursor<Integer>] Cursor object that contains follower ids
      def follower_ids(user=current_user, params={})
        merge_user!(params, user)
        resp = get('/followers/ids.json', params)
        Croudia::Cursor.new(:ids, nil, resp)
      end

      # Friends of specified user
      #
      # @see https://developer.croudia.com/docs/40_friends_list
      # @overload friends(user=current_user, params={})
      #   @param [String, Integer, Croudia::User] user User to look up friends of
      #   @param [Hash] params Additional query parameters
      #   @option params [String, Integer] :cursor Cursor number, -1 to get the first page
      #   @option params [String] :trim_user Set true to return compact user objects
      # @overload friends(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String, Integer] :cursor Cursor number, -1 to get the first page
      #   @option params [String] :screen_name Screen name of the user to look up friends of
      #   @option params [String] :trim_user Set true to return compact user objects
      #   @option params [String, Integer] :user_id ID of the user to look up friends of
      # @return [Croudia::Cursor<Croudia::User>] Cursor object that contains friends
      def friends(user=current_user, params={})
        merge_user!(params, user)
        resp = get('/friends/list.json', params)
        Croudia::Cursor.new(:users, Croudia::User, resp)
      end

      # Followers of specified user
      #
      # @see https://developer.croudia.com/docs/43_followers_list
      # @overload followers(user=current_user, params={})
      #   @param [String, Integer, Croudia::User] user User to look up followers of
      #   @param [Hash] params Additional query parameters
      #   @option params [String, Integer] :cursor Cursor number, -1 to get the first page
      #   @option params [String] :trim_user Set true to return compact user objects
      # @overload followers(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String, Integer] :cursor Cursor number, -1 to get the first page
      #   @option params [String] :screen_name Screen name of the user to look up followers of
      #   @option params [String] :trim_user Set true to return compact user objects
      #   @option params [String, Integer] :user_id ID of the user to look up followers of
      # @return [Croudia::Cursor<Croudia::User>] Cursor object that contains followers
      def followers(user=current_user, params={})
        merge_user!(params, user)
        resp = get('/followers/list.json', params)
        Croudia::Cursor.new(:users, Croudia::User, resp)
      end
    end
  end
end
