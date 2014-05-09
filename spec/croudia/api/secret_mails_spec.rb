require 'helper'

describe Croudia::API::SecretMails do
  before do
    @client = Croudia::Client.new
  end

  describe '#secret_mails' do
    before do
      stub_get('/secret_mails.json').to_return(
        body: fixture(:secret_mails),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.secret_mails
      expect(a_get('/secret_mails.json')).to have_been_made
    end

    it 'returns Array of Croudia::SecretMail' do
      subject = @client.secret_mails
      expect(subject).to be_an Array
      subject.each { |s| expect(s).to be_a Croudia::SecretMail }
    end
  end

  describe '#secret_mails_sent' do
    before do
      stub_get('/secret_mails/sent.json').to_return(
        body: fixture(:secret_mails),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.secret_mails_sent
      expect(a_get('/secret_mails/sent.json')).to have_been_made
    end

    it 'returns Array of Croudia::SecretMail' do
      subject = @client.secret_mails_sent
      expect(subject).to be_an Array
    end
  end

  describe '#send_secret_mail' do
    before do
      stub_post('/secret_mails/new.json').to_return(
        body: fixture(:secret_mail),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    context 'when passing text as the first argument' do
      context 'when passing user as String (screen_name)' do
        it 'requests the correct resource' do
          @client.send_secret_mail('Hello', 'wktk')
          expect(a_post('/secret_mails/new.json').with(
            body: { 
              text: 'Hello',
              screen_name: 'wktk',
            }
          )).to have_been_made
        end
      end

      context 'when passing user as Integer (user_id)' do
        it 'requests the correct resource' do
          @client.send_secret_mail('Hello?', 1234)
          expect(a_post('/secret_mails/new.json').with(
            body: {
              text: 'Hello?',
              user_id: '1234',
            }
          )).to have_been_made
        end
      end

      context 'when passing user as Croudia::User' do
        it 'requests the correct resource' do
          user = Croudia::User.new('id' => 1234)
          @client.send_secret_mail('Hello!', user)
          expect(a_post('/secret_mails/new.json').with(
            body: {
              text: 'Hello!',
              user_id: '1234',
            }
          )).to have_been_made
        end
      end
    end

    context 'when passing all params as Hash' do
      it 'requests the correct resource' do
        @client.send_secret_mail(text: 'Hi', screen_name: 'wktk')
        expect(a_post('/secret_mails/new.json').with(
          body: {
            text: 'Hi',
            screen_name: 'wktk',
          }
        )).to have_been_made
      end
    end

    it 'returns Croudia::SecretMail' do
      subject = @client.send_secret_mail('hi', 1234)
      expect(subject).to be_a Croudia::SecretMail
    end
  end

  describe '#send_secret_mail_with_media' do
    before do
      stub_post('/secret_mails/new_with_media.json').to_return(
        body: fixture(:secret_mail),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.send_secret_mail_with_media('hi', 1234, fixture('image.jpg'))
      expect(a_post('/secret_mails/new_with_media.json')).to have_been_made
    end

    it 'returns Croudia::SecretMail' do
      subject = @client.send_secret_mail_with_media('hi', 1234, fixture('image.jpg'))
      expect(subject).to be_a Croudia::SecretMail
    end
  end

  describe '#destroy_secret_mail' do
    before do
      stub_post('/secret_mails/destroy/1234.json').to_return(
        body: fixture(:secret_mail),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.destroy_secret_mail(1234)
      expect(a_post('/secret_mails/destroy/1234.json')).to have_been_made
    end

    it 'can destroy Croudia::SecretMail' do
      @client.destroy_secret_mail(Croudia::SecretMail.new('id' => 1234))
      expect(a_post('/secret_mails/destroy/1234.json')).to have_been_made
    end

    it 'returns Croudia::SecretMail' do
      subject = @client.destroy_secret_mail(1234)
      expect(subject).to be_a Croudia::SecretMail
    end
  end

  describe '#show_secret_mail' do
    before do
      stub_get('/secret_mails/show/1234.json').to_return(
        body: fixture(:secret_mail),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.show_secret_mail(1234)
      expect(a_get('/secret_mails/show/1234.json')).to have_been_made
    end

    it 'returns Croudia::SecretMail' do
      subject = @client.show_secret_mail(1234)
      expect(subject).to be_a Croudia::SecretMail
    end
  end

  describe '#secret_photo' do
    before do
      stub_get('/secret_mails/get_secret_photo/123').to_return(
        body: fixture('image.jpg'),
        headers: { content_type: 'image/jpg' }
      )
    end

    it 'requests the correct resource' do
      @client.secret_photo(123)
      expect(a_get('/secret_mails/get_secret_photo/123')).to have_been_made
    end

    it 'returns a photo in String' do
      expect(@client.secret_photo(123)).to eq fixture('image.jpg').read
    end
  end

end
