require 'helper'

describe Croudia::API::Friendships do
  before do
    @client = Croudia::Client.new
  end

  describe '#follow' do
    before do
      stub_post('/friendships/create.json').to_return(
        body: fixture(:user),
        headers: { content_type: 'application/json; chrset=utf-8' }
      )
    end

    context 'when string is passed' do
      it 'requests the correct resource' do
        @client.follow('wktk')
        expect(a_post('/friendships/create.json').with(
          body: { screen_name: 'wktk' }
        )).to have_been_made
      end
    end

    context 'when integer is passed' do
      it 'requests the correct resource' do
        @client.follow(1234)
        expect(a_post('/friendships/create.json').with(
          body: { user_id: '1234' }
        )).to have_been_made
      end
    end

    context 'when hash is passed' do
      it 'requests the correct resource' do
        @client.follow(screen_name: 'wktk')
        expect(a_post('/friendships/create.json').with(
          body: { screen_name: 'wktk' }
        )).to have_been_made
      end
    end

    it 'returns User object' do
      expect(@client.follow('wktk')).to be_a Croudia::User
    end
  end

  describe '#unfollow' do
    before do
      stub_post('/friendships/destroy.json').to_return(
        body: fixture(:user),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    context 'when string is passed' do
      it 'requests the correct resource' do
        @client.unfollow('wktk')
        expect(a_post('/friendships/destroy.json').with(
          body: { screen_name: 'wktk' }
        )).to have_been_made
      end
    end

    context 'when integer is passed' do
      it 'requests the correct resource' do
        @client.unfollow(1234)
        expect(a_post('/friendships/destroy.json').with(
          body: { user_id: '1234' }
        )).to have_been_made
      end
    end

    context 'when hash is passed' do
      it 'requests the correct resource' do
        @client.unfollow(screen_name: 'wktk')
        expect(a_post('/friendships/destroy.json').with(
          body: { screen_name: 'wktk' }
        )).to have_been_made
      end
    end

    it 'returns User object' do
      expect(@client.unfollow('wktk')).to be_a Croudia::User
    end
  end
end
