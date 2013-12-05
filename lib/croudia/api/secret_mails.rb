require 'croudia/secret_mail'

module Croudia
  module API
    module SecretMails
      # Get incoming secret mails
      #
      # @see https://developer.croudia.com/docs/21_secret_mails
      # @param [Hash] params Additional query parameters
      # @option params [String, Integer] :count Number of secret mails in the response
      # @option params [String, Integer] :max_id Paging parameter
      # @option params [String, Integer] :since_id Paging parameter
      # @return [Array<Croudia::SecretMail>]
      def secret_mails(params={})
        resp = get('/secret_mails.json', params)
        objects(Croudia::SecretMail, resp)
      end

      # Get outgoing secret mails
      #
      # @see https://developer.croudia.com/docs/22_secret_mails_sent
      # @param [Hash] params Additional query parameters
      # @option params [String, Integer] :count Number of secret mails in the response
      # @option params [String, Integer] :max_id Paging parameter
      # @option params [String, Integer] :since_id Paging parameter
      # @return [Array<Croudia::SecretMail>]
      def secret_mails_sent(params={})
        resp = get('/secret_mails/sent.json', params)
        objects(Croudia::SecretMail, resp)
      end

      # Send a new secret mail
      #
      # @see https://developer.croudia.com/docs/23_secret_mails_new
      # @overload send_secret_mail(text, to_user, params={})
      #   @param [String] text Message body
      #   @param [String, Integer, Croudia::User] to_user Recipient user
      #   @param [Hash] params Additional query parameters
      # @overload send_secret_mail(params={})
      #   @param [Hash] params Query parameters
      #   @option params [String] :screen_name Screen name of the recipient
      #   @option params [String] :text Message body
      #   @option params [String, Integer] :user_id ID of the recipient
      # @return [Croudia::SecretMail] Sent message
      def send_secret_mail(text, to_user={}, params={})
        merge_text!(params, text, :text)
        merge_user!(params, to_user)

        resp = post('/secret_mails/new.json', params)
        Croudia::SecretMail.new(resp)
      end

      # Destroy a secret mail
      #
      # @see https://developer.croudia.com/docs/24_secret_mails_destroy
      # @param [String, Integer, Croudia::SecretMail] id ID of the secret mail to delete
      # @param [Hash] params Additional query params
      # @return [Croudia::SecretMail] Deleted secret mail
      def destroy_secret_mail(id, params={})
        resp = post("/secret_mails/destroy/#{get_id(id)}.json", params)
        Croudia::SecretMail.new(resp)
      end

      # Get a secret mail
      #
      # @see https://developer.croudia.com/docs/25_secret_mails_show
      # @param [String, Integer, Croudia::SecretMail] id ID of the secret mail to get
      # @param [Hash] params Additional query parameters
      # @return [Croudia::SecretMail]
      def show_secret_mail(id, params={})
        resp = get("/secret_mails/show/#{get_id(id)}.json", params)
        Croudia::SecretMail.new(resp)
      end
    end
  end
end
