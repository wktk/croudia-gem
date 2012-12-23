require 'croudia/error'
require 'croudia/scraper/friendships'
require 'croudia/scraper/login'
require 'croudia/scraper/parser'
require 'croudia/scraper/users'
require 'croudia/scraper/voices'
require 'croudia/user'
require 'croudia/version'
require 'croudia/voice'
require 'mechanize'

module Croudia
  class Scraper
    include Croudia::Scraper::Friendships
    include Croudia::Scraper::Login
    include Croudia::Scraper::Users
    include Croudia::Scraper::Voices

    attr_accessor :agent, :endpoint

    def initialize(username=nil, password=nil)
      yield self if block_given?

      @endpoint ||= 'https://croudia.com'
      @user_agent ||= "The Croudia Gem/#{Croudia::VERSION} (https://github.com/wktk/croudia-gem)"
      @agent ||= Mechanize.new do |s|
        s.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      self.user_agent = @user_agent

      username && password && login(username, password)
    end

    def user_agent
      @agent.user_agent
    end

    def user_agent=(ua)
      unless @agent
        @user_agent = ua
      else
        @agent.user_agent = ua
      end
    end

    def get(path, params={})
      pick_token(@agent.get(@endpoint + path, params))
    end

    def post(path, params={})
      params = { :authenticity_token => @authenticity_token }.merge(params)
      pick_token(@agent.post(@endpoint + path, params))
    end

  private
    def pick_token(page)
      page.respond_to?('parser') &&
        (token = page.parser.xpath('//meta[@name="csrf-token"]')).size.nonzero? &&
          @authenticity_token = token.first.attribute('content').content
      page
    end
  end
end
