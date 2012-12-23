module Croudia
  class Scraper
    module Voices
      def timeline(params={})
        require_login
        Parser.voices(get('/voices/timeline', params))
      end
      alias home_timeline timeline

      def reply_list(params={})
        require_login
        Parser.voices(get('/voices/reply_list', params))
      end
      alias mentions reply_list
      alias mentions_timeline reply_list
    end
  end
end
