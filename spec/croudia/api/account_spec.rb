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
end
