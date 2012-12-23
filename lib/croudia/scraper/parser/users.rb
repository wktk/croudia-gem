module Croudia
  class Scraper
    module Parser
      module Users
        def user_page(page)
          return nil if /on Croudia$/ !~ page.title
          doc = page.parser
          attrs = {
            :username => doc.xpath('//a[contains(@href, "/voices/user/")]').first.attribute('href').content.sub(%r{^/voices/user/}, ''),
            :nickname => doc.css('.avatar_l').first.attribute('alt').content,
            :avatar => "#{page.uri.scheme}://#{page.uri.host}" + doc.css('.avatar_l').first.attribute('src').content,
            :self_introduction => doc.css('.fontg').first.content.strip,
            :voices_count => doc.xpath('//span[preceding-sibling::a[contains(@href,"/voices/user/")]]').first.content,
            :following_count => doc.xpath('//span[preceding-sibling::a[contains(@href,"/following/")]]').first.content,
            :followers_count => doc.xpath('//span[preceding-sibling::a[contains(@href,"/follower/")]]').first.content,
            :album_count => doc.xpath('//span[preceding-sibling::a[contains(@href,"/album")]]').first.content,
            :spreadia => doc.xpath('//span[preceding-sibling::a[contains(@href,"/spreadia/")]]').first.content,
            :favodia => doc.xpath('//span[preceding-sibling::a[contains(@href,"/favodia/")]]').first.content,
          }
          if (location = doc.xpath('//a[contains(@href, "/users/google_maps")]')).size.nonzero?
            attrs[:position] = location.first.content
          end
          if (url = doc.xpath('//a[@target="_blank"][name(..)="li"]')).size.nonzero?
            attrs[:user_url] = url.first.content
          end
          if (friendships = doc.css('.font1')).size.nonzero?
            attrs[:following] = /#e/i !~ friendships[0].attribute('style').value
            attrs[:followed_by] = /#e/i !~ friendships[1].attribute('style').value
          end
          Croudia::User.new(attrs)
        end

        def user_list(page)
          user_nodes = page.parser.xpath('//div[@data-role="content"]/ul[@data-role="listview"]/li[not(@data-role="list-divider")]')
          users = []
          user_nodes.each do |user_node|
            attrs = {
              :nickname => user_node.css('.bord').first.content,
              :avatar => "#{page.uri.scheme}://#{page.uri.host}" + user_node.css('img').first.attribute('src').value,
              :self_introduction => user_node.css('.fontg').first.content.strip,
            }
            if (links = user_node.css('a')).size.nonzero?
              # For following/followers page
              attrs[:username] = links.first.attribute('href').value.sub(%r{^/}, '')
            elsif (forms = user_node.xpath('//form[not(contains(@action,"/follows/"))]')).size.nonzero?
              # For follow_request page
              attrs[:username] = forms.first.attribute('action').value.sub(%r{^/}, '')
            end
            if (following = user_node.css('.font1')).size.nonzero?
              attrs[:following] = /#e/i !~ following.first.attribute('style').value
            end
            users << Croudia::User.new(attrs)
          end
          users
        end
      end
    end
  end
end
