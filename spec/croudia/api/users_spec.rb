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

  describe '#users' do
    context 'when String is passed' do
      before do
        stub_get('/users/lookup.json').with(
          query: {
            screen_name: 'wktk',
          }
        ).to_return(
          body: fixture(:users),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource' do
        @client.users('wktk')
        expect(a_get('/users/lookup.json').with(
          query: {
            screen_name: 'wktk',
          }
        )).to have_been_made
      end

      it 'returns array of Croudia::User' do
        subject = @client.users('wktk')
        expect(subject).to be_an Array
        subject.each { |u| expect(u).to be_a Croudia::User }
      end
    end

    context 'when Integer is passed' do
      before do
        stub_get('/users/lookup.json').with(
          query: {
            user_id: '1234',
          }
        ).to_return(
          body: fixture(:users),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource' do
        @client.users(1234)
        expect(a_get('/users/lookup.json').with(
          query: {
            user_id: '1234',
          }
        )).to have_been_made
      end
    end

    context 'when multiple Strings are passed' do
      before do
        stub_get('/users/lookup.json').with(
          query: {
            screen_name: 'wktk,croudia',
          }
        ).to_return(
          body: fixture(:users),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource' do
        @client.users('wktk', 'croudia')
        expect(a_get('/users/lookup.json').with(
          query: {
            screen_name: 'wktk,croudia',
          }
        )).to have_been_made
      end
    end

    context 'when multiple Integers are passed' do
      before do
        stub_get('/users/lookup.json').with(
          query: {
            user_id: '1234,4567',
          }
        ).to_return(
          body: fixture(:users),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource' do
        @client.users(1234, 4567)
        expect(a_get('/users/lookup.json').with(
          query: {
            user_id: '1234,4567',
          }
        )).to have_been_made
      end
    end

    context 'when multiple String and Integer are passed' do
      before do
        stub_get('/users/lookup.json').with(
          query: {
            user_id: '1234,4567',
            screen_name: 'wktk,croudia',
          }
        ).to_return(
          body: fixture(:users),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource' do
        @client.users('wktk', 1234, 'croudia', 4567)
        expect(a_get('/users/lookup.json').with(
          query: {
            user_id: '1234,4567',
            screen_name: 'wktk,croudia',
          }
        )).to have_been_made
      end
    end
  end
end
