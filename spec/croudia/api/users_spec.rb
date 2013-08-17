require 'helper'

describe Croudia::API::Users do
  before do
    @client = Croudia::Client.new
  end

  describe '#user' do
    before do
      stub_get('/users/show.json').with(
        query: { screen_name: 'wktk' }
      ).to_return(
        body: fixture(:user),
        headers: { content_type: 'application/json; chrset=utf-8' }
      )

      stub_get('/users/show.json').with(
        query: { user_id: 1234 }
      ).to_return(
        body: fixture(:user),
        headers: { content_type: 'application/json; chrset=utf-8' }
      )
    end

    context 'when string is passed' do
      it 'requests the correct resource' do
        @client.user('wktk')
        expect(a_get('/users/show.json').with(
          query: { screen_name: 'wktk' }
        )).to have_been_made
      end
    end

    context 'when integer is passed' do
      it 'requests the correct resource' do
        @client.user(1234)
        expect(a_get('/users/show.json').with(
          query: { user_id: 1234 }
        )).to have_been_made
      end
    end

    context 'when hash is passed' do
      it 'requests the correct resource' do
        @client.user(screen_name: 'wktk')
        expect(a_get('/users/show.json').with(
          query: { screen_name: 'wktk' }
        )).to have_been_made
      end
    end

    it 'returns User object' do
      expect(@client.user('wktk')).to be_a Croudia::User
    end
  end
end
