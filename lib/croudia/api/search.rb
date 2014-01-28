require 'croudia/search_results'
require 'croudia/user'

module Croudia
  module API
    module Search
      # Search for statuses
      #
      # @see https://developer.croudia.com/docs/81_search
      # @overload search(q, params={})
      #   @param [String] q Search query
      #   @param [Hash] params Additional query parameters
      #   @option params [String, Integer] :count Number of statuses in the response
      #   @option params [String] :include_entities Set false to exclude entities
      #   @option params [String, Integer] :max_id Paging parameter
      #   @option params [String, Integer] :since_id Paging parameter
      #   @option params [String] :trim_user Set true to return compact user objects
      # @overload search(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String] :q Search query
      #   @option params [String, Integer] :count Number of statuses in the response
      #   @option params [String] :include_entities Set false to exclude entities
      #   @option params [String, Integer] :max_id Paging parameter
      #   @option params [String, Integer] :since_id Paging parameter
      #   @option params [String] :trim_user Set true to return compact user objects
      # @return [Croudia::SearchResults]
      def search(q, params={})
        merge_query!(params, q)
        resp = get('/search/voices.json', params)
        Croudia::SearchResults.new(resp)
      end

      # Search for users
      #
      # @see https://developer.croudia.com/docs/82_users_search
      # @overload search_user(q, params={})
      #   @param [String] q Search query
      #   @param [Hash] params Additional query parameters
      #   @option params [String, Integer] :count Number of users in the response
      #   @option params [String] :include_entities Set false to exclude entities
      #   @option params [String, Integer] :max_id Paging parameter
      #   @option params [String, Integer] :since_id Paging parameter
      #   @option params [String] :trim_user Set true to return compact user objects
      # @overload search_user(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String] :q Search query
      #   @option params [String, Integer] :count Number of users in the response
      #   @option params [String, Integer] :page Page to fetch, up to 1000
      #   @option params [String] :trim_user Set true to return compact user objects
      # @return [Array<Croudia::User>] Users found
      def search_user(q, params={})
        merge_query!(params, q)
        resp = get('/users/search.json', params)
        objects(Croudia::User, resp)
      end

      # Search for users with profile
      #
      # @see https://developer.croudia.com/docs/83_profile_search
      # @overload search_user(q, params={})
      #   @param [String] q Search query
      #   @param [Hash] params Additional query parameters
      #   @option params [String, Integer] :count Number of users in the response
      #   @option params [String] :include_entities Set false to exclude entities
      #   @option params [String, Integer] :max_id Paging parameter
      #   @option params [String, Integer] :since_id Paging parameter
      #   @option params [String] :trim_user Set true to return compact user objects
      # @overload search_user(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String] :q Search query
      #   @option params [String, Integer] :count Number of users in the response
      #   @option params [String, Integer] :page Page to fetch, up to 1000
      #   @option params [String] :trim_user Set true to return compact user objects
      # @return [Array<Croudia::User>] Users found
      def search_user(q, params={})
        merge_query!(params, q)
        resp = get('/profile/search.json', params)
        objects(Croudia::User, resp)
      end
      
      # Search for statuses have favorited
      #
      # @see https://developer.croudia.com/docs/84_search_favorites
      # @overload search(q, params={})
      #   @param [String] q Search query
      #   @param [Hash] params Additional query parameters
      #   @option params [String, Integer] :count Number of statuses in the response
      #   @option params [String] :include_entities Set false to exclude entities
      #   @option params [String, Integer] :max_id Paging parameter
      #   @option params [String, Integer] :since_id Paging parameter
      #   @option params [String] :trim_user Set true to return compact user objects
      # @overload search(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String] :q Search query
      #   @option params [String, Integer] :count Number of statuses in the response
      #   @option params [String] :include_entities Set false to exclude entities
      #   @option params [String, Integer] :max_id Paging parameter
      #   @option params [String, Integer] :since_id Paging parameter
      #   @option params [String] :trim_user Set true to return compact user objects
      # @return [Croudia::SearchResults]
      def search(q, params={})
        merge_query!(params, q)
        resp = get('/search/favorites.json', params)
        Croudia::SearchResults.new(resp)
      end
      alias search_users search_user
    end
  end
end
