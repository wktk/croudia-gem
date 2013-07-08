require 'cgi'
require 'helper'
require 'uri'

describe Croudia::API::OAuth do
  before do
    options = { client_id: 'cid-value', client_secret: 'cs-value' }
    @client = Croudia::Client.new(options)
  end

  describe '#authorize_url' do
    it 'returns the correct url' do
      uri = URI.parse(@client.authorize_url)
      expect(uri.path).to eq '/oauth/authorize'
      expect(CGI.parse(uri.query)).to eq({
        'response_type' => ['code'],
        'client_id' => ['cid-value'],
      })
    end

    it 'does not include the client_secret in URL' do
      url = @client.authorize_url
      expect(url).not_to include('cs-value')
    end
    
    it 'includes argument hash to the URL' do
      url = @client.authorize_url(hoge: 'fuga', foo: :bar)
      query = CGI.parse(URI.parse(url).query)
      expect(query['hoge']).to include('fuga')
      expect(query['foo']).to include('bar')
    end
  end

  describe '#get_access_token' do
    before do
      stub_post('/oauth/token').to_return(
        body: fixture(:access_token),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.get_access_token(code: 'code-value')
      expect(a_post('/oauth/token').with(
        body: {
          code: 'code-value',
          grant_type: 'authorization_code',
          client_id: 'cid-value',
          client_secret: 'cs-value',
      })).to have_been_made
    end

    it 'returns the correct token' do
      access_token = @client.get_access_token(code: 'code_value')
      expect(access_token['access_token']).to eq 'access_token_value'
    end

    it 'can return a token via #access_token' do
      access_token = @client.get_access_token(code: 'code_value')
      expect(access_token.access_token).to eq 'access_token_value'
    end
  end
end
