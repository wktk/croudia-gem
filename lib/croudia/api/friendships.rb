require 'croudia/cursor'
require 'croudia/relationship'
require 'croudia/user'

module Croudia
  module API
    module Friendships
      # Follow a user
      #
      # @param user [String. Integer, Croudia::User]
      # @param params [Hash] Optional params
      # @return [Croudia::User] Followed user
      def follow(user, params={})
        merge_user!(params, user)
        resp = post('/friendships/create.json', params)
        Croudia::User.new(resp)
      end

      # Unfollow a user
      #
      # @param user [String, Integer, Croudia::User]
      # @param params
      # @return [Croudia::User] Unfollowed user
      def unfollow(user, params={})
        merge_user!(params, user)
        resp = post('/friendships/destroy.json', params)
        Croudia::User.new(resp)
      end

      # Show relationship between two users
      #
      # @param source [String, Integer, Croudia::User]
      # @param target [String, Integer, Croudia::User]
      # @param params [Hash]
      # @return [Croudia::Relationship]
      def friendship(source, target={}, params={})
        merge_user!(params, source, :source_screen_name, :source_id)
        merge_user!(params, target, :target_screen_name, :target_id)
        resp = get('/friendships/show.json', params)
        Croudia::Relationship.new(resp)
      end

      # Lookup Friendships
      #
      # @param *users [String, Integer, Croudia::User]
      # @param params [Hash]
      # @return [Array<Croudia::User>]
      def friendships(*args)
        merge_users!(params = {}, args)
        resp = get('/friendships/lookup.json', params)
        objects(Croudia::User, resp)
      end

      # Friend ids of specified user
      #
      # @param user [String, Integer, Croudia::User]
      # @param params [Hash]
      # @return [Croudia::Cursor] Cursor object that contains friend ids
      def friend_ids(user=current_user, params={})
        merge_user!(params, user)
        resp = get('/friends/ids.json', params)
        Croudia::Cursor.new(:ids, nil, resp)
      end

      # Follower ids of specified user
      #
      # @param user [String, Integer, Croudia::User]
      # @param params [Hash]
      # @return [Croudia::Cursor]
      def follower_ids(user=current_user, params={})
        merge_user!(params, user)
        resp = get('/followers/ids.json', params)
        Croudia::Cursor.new(:ids, nil, resp)
      end

      # Friends of specified user
      #
      # @param user [String, Integer, Croudia::User]
      # @param params [Hash]
      # @return [Croudia::Cursor]
      def friends(user=current_user, params={})
        merge_user!(params, user)
        resp = get('/friends/list.json', params)
        Croudia::Cursor.new(:users, Croudia::User, resp)
      end

      # Followers of specified user
      #
      # @param user [String, Integer, Croudia::User]
      # @param params [Hash]
      # @return [Croudia::Cursor]
      def followers(user=current_user, params={})
        merge_user!(params, user)
        resp = get('/followers/list.json', params)
        Croudia::Cursor.new(:users, Croudia::User, resp)
      end
    end
  end
end
