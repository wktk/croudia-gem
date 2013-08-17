require 'faraday'
require 'helper'

describe Croudia::Error do
  before do
    @client = Croudia::Client.new
  end

  context 'connection error' do
    before do
      stub_get('/account/verify_credentials.json').to_raise Faraday::Error::ConnectionFailed
    end

    it 'raises Croudia::Error::ConnectionFailed' do
      expect { @client.verify_credentials }.to raise_error Croudia::Error::ConnectionFailed
    end
  end

  context 'client error' do
    before do
      stub_get('/account/verify_credentials.json').to_return(
        status: 401,
        body: fixture(:error),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'raises Croudia::Error::ClientError' do
      expect { @client.verify_credentials }.to raise_error Croudia::Error::ClientError
    end
  end

  context 'server error' do
    before do
      stub_get('/account/verify_credentials.json').to_return(
        status: 502,
        body: fixture(:error),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'raises Croudia::Error::ServerError' do
      expect { @client.verify_credentials }.to raise_error Croudia::Error::ServerError
    end
  end
end
