require 'helper'

describe Croudia::API::Account do
  before do
    @client = Croudia::Client.new
  end

  describe '#verify_credentials' do
    before do
      stub_get('/account/verify_credentials.json').to_return(
        body: fixture(:user),
        header: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.verify_credentials
      expect(a_get('/account/verify_credentials.json')).to have_been_made
    end

    it 'returns a User object' do
      expect(@client.verify_credentials).to be_a Croudia::User
    end
  end

  describe '#update_profile_image' do
    before do
      stub_post('/account/update_profile_image.json').to_return(
        body: fixture(:user),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.update_profile_image(fixture('image.jpg'))
      expect(a_post('/account/update_profile_image.json')).to have_been_made
    end

    it 'returns a Croudia::User' do
      subject = @client.update_profile_image(fixture('image.jpg'))
      expect(subject).to be_a Croudia::User
    end
  end

  describe '#update_profile' do
    before do
      stub_post('/account/update_profile.json').to_return(
        body: fixture(:user),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.update_profile(name: 'name', url: 'http://example.com')
      expect(a_post('/account/update_profile.json').with(
        body: {
          name: 'name',
          url: 'http://example.com',
        }
      )).to have_been_made
    end

    it 'returns a Croudia::User' do
      subject = @client.update_profile(name: 'name', location: 'Japan')
      expect(subject).to be_a Croudia::User
    end
  end
end
