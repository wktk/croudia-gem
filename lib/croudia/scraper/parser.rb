require 'croudia/scraper/parser/users'
require 'croudia/scraper/parser/voices'

module Croudia
  class Scraper
    module Parser
      class << self
        include Croudia::Scraper::Parser::Users
        include Croudia::Scraper::Parser::Voices
      end
    end
  end
end
