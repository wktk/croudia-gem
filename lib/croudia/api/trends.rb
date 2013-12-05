require 'croudia/trend'
require 'croudia/trend_results'

module Croudia
  module API
    module Trends
      # Retrieve the current trends
      #
      # @see https://developer.croudia.com/docs/100_trends_place
      # @param [Hash] params Query parameters
      # @option params [String, Integer] :id ("1") Location ID
      # @return [Croudia::TrendResults<Croudia::Trend>]
      def trends(params={})
        params[:id] ||= '1'
        resp = get('/trends/place.json', params)
        Croudia::TrendResults.new(resp)
      end
    end
  end
end
