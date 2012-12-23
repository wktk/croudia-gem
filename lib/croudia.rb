require 'croudia/scraper'

module Croudia
  class << self
    # Delegate to Croudia::Scraper.new
    #
    # @return [Croudia::Scraper]
    def scraper(*args, &block)
      Croudia::Scraper.new(*args, &block)
    end
    alias new scraper
    alias client scraper

    def method_missing(name, *args, &block)
      return super unless scraper.respond_to?(name)
      scraper.send(name, *args, &block)
    end

    def respond_to?(name)
      scraper.respond_to?(name) || super
    end
  end
end
