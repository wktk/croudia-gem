require 'helper'

describe Croudia::API::Favorites do
  before do
    @client = Croudia::Client.new
  end

  describe '#favorites' do
    context 'when user is not specified' do
      before do
        stub_get('/favorites.json').to_return(
          body: fixture(:timeline),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource' do
        @client.favorites
        expect(a_get('/favorites.json')).to have_been_made
      end

      it 'returns Array of Croudia::Status' do
        subject = @client.favorites
        expect(subject).to be_an Array
        subject.each { |s| expect(s).to be_a Croudia::Status }
      end
    end

    context 'when user is specified' do
      before do
        stub_get('/favorites/wktk.json').to_return(
          body: fixture(:timeline),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource' do
        @client.favorites('wktk')
        expect(a_get('/favorites/wktk.json')).to have_been_made
      end
    end
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

    it 'returns a Status object' do
      expect(@client.favorite(1234)).to be_a Croudia::Status
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

    it 'returns a Status object' do
      expect(@client.unfavorite(1234)).to be_a Croudia::Status
    end
  end
end
