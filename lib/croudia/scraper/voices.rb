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

      def update(text)
        require_login
        page = get('/voices/written')
        form = page.form_with(:action => '/voices/write')
        form['voice[tweet]'] = text
        result = form.submit
        raise 'Update failed' if result.body.include? 'error_popup'
      end
    end
  end
end
