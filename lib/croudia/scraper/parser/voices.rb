module Croudia
  class Scraper
    module Parser
      module Voices
        def voices(page)
          voice_nodes = page.parser.xpath('//div[@data-role="content"]/ul[@data-role="listview"]/li[child::a]')
          voices = []
          voice_nodes.each do |voice|
            user = Croudia::User.new(
              :username => voice.xpath('//a[parent::span[@class="test_span"]]').first.attribute('href').value.gsub(/\W/, ''),
              :nickname => voice.xpath('//span[@class="bord"][parent::p]').first.content,
              :avatar => "#{page.uri.scheme}://#{page.uri.host}" + voice.xpath('//img[@class="avatar"]').attribute('src').value,
            )
            attrs = {
              :id => voice.xpath('//a[contains(@href,"/voices/show/")]').first.attribute('href').value.gsub(/\D/, ''),
              :user => user,
              :voice_desc => voice.css('.voice_desc').first.content,
              :spreaded_count => voice.xpath('//span[contains(@style,"#396")]').first.content.gsub(/\D/, ''),
              :favorited_count => voice.xpath('//span[contains(@style,"520")]').first.content.gsub(/\D/, ''),
            }
            if (time = voice.xpath('//p[@data-time]')).size.nonzero?
              # For timeline
              attrs[:time] = time.first.attribute('data-time').value
            end
            voices << Croudia::Voice.new(attrs)
          end
          voices
        end
      end
    end
  end
end
