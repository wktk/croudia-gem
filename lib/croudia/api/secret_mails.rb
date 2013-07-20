require 'croudia/secret_mail'

module Croudia
  module API
    module SecretMails
      # Get incoming secret mails
      #
      # @param params [Hash]
      # @return [Array<Croudia::SecretMails>]
      def secret_mails(params={})
        resp = get('/secret_mails.json', params)
        objects(Croudia::SecretMail, resp)
      end

      # Get outgoing secret mails
      #
      # @param params [Hash]
      # @return [Array<Croudia::SecretMail>]
      def secret_mails_sent(params={})
        resp = get('/secret_mails/sent.json', params)
        objects(Croudia::SecretMail, resp)
      end

      # Send a new secret mail
      #
      # @param text [String] Message body
      # @param to_user [String, Integer, Croudia::User] Recipient user
      # @param params [Hash]
      def send_secret_mail(text, to_user={}, params={})
        merge_text!(params, text, :text)
        merge_user!(params, to_user)

        resp = post('/secret_mails/new.json', params)
        Croudia::SecretMail.new(resp)
      end

      # Destroy a secret mail
      #
      # @param id [Integer, String, Croudia::SecretMail]
      # @param params [Hash]
      # @return [Croudia::SecretMail]
      def destroy_secret_mail(id, params={})
        resp = post("/secret_mails/destroy/#{get_id(id)}.json", params)
        Croudia::SecretMail.new(resp)
      end

      # Get a secret mail
      #
      # @param id [Integer, String, Croudia::SecretMail]
      # @param params [Hash]
      # @return [Croudia::SecretMail]
      def show_secret_mail(id, params={})
        resp = get("/secret_mails/show/#{get_id(id)}.json", params)
        Croudia::SecretMail.new(resp)
      end
    end
  end
end
