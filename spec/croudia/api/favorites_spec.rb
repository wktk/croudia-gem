require 'helper'

describe Croudia::API::Favorites do
  before do
    @client = Croudia::Client.new
  end

  describe '#favorite' do
    before do
      stub_post('/favorites/create/1234.json').to_return(
        body: fixture(:status),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.favorite(1234)
      expect(a_post('/favorites/create/1234.json')).to have_been_made
    end
  end

  describe '#unfavorite' do
    before do
      stub_delete('/favorites/destroy/1234.json').to_return(
        body: fixture(:status),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.unfavorite(1234)
      expect(a_delete('/favorites/destroy/1234.json')).to have_been_made
    end
  end
end
