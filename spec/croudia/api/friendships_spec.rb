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

  describe '#friendship' do
    before do
      stub_get('/friendships/show.json').with(
        query: {
          source_id: '1234',
          target_id: '3456',
        }
      ).to_return(
        body: fixture(:friendship),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    context 'when passing a Hash' do
      it 'requests the correct resource' do
        @client.friendship(source_id: 1234, target_id: 3456)
        expect(a_get('/friendships/show.json').with(
          query: {
            source_id: '1234',
            target_id: '3456',
          }
        )).to have_been_made
      end
    end

    context 'when passing each argument' do
      it 'requests the correct resource' do
        @client.friendship(1234, 3456)
        expect(a_get('/friendships/show.json').with(
          query: {
            source_id: '1234',
            target_id: '3456',
          }
        )).to have_been_made
      end
    end

    it 'returns a Relationship' do
      subject = @client.friendship(1234, 3456)
      expect(subject).to be_a Croudia::Relationship
    end
  end

  describe '#friendships' do
    context 'when String is passed' do
      before do
        stub_get('/friendships/lookup.json').with(
          query: {
            screen_name: 'wktk',
          }
        ).to_return(
          body: fixture(:friendships),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource' do
        @client.friendships('wktk')
        expect(a_get('/friendships/lookup.json').with(
          query: {
            screen_name: 'wktk',
          }
        )).to have_been_made
      end

      it 'returns array of Croudia::User' do
        subject = @client.friendships('wktk')
        expect(subject).to be_an Array
        subject.each { |u| expect(u).to be_a Croudia::User }
      end
    end

    context 'when Integer is passed' do
      before do
        stub_get('/friendships/lookup.json').with(
          query: {
            user_id: '1234',
          }
        ).to_return(
          body: fixture(:friendships),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource' do
        @client.friendships(1234)
        expect(a_get('/friendships/lookup.json').with(
          query: { 
            user_id: '1234',
          }
        )).to have_been_made
      end
    end

    context 'when multiple Strings are passed' do
      before do
        stub_get('/friendships/lookup.json').with(
          query: {
            screen_name: 'wktk,croudia',
          }
        ).to_return(
          body: fixture(:friendships),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource' do
        @client.friendships('wktk', 'croudia')
        expect(a_get('/friendships/lookup.json').with(
          query: {
            screen_name: 'wktk,croudia',
          }
        )).to have_been_made
      end
    end

    context 'when multiple Integers are passed' do
      before do
        stub_get('/friendships/lookup.json').with(
          query: {
            user_id: '1234,4567',
          }
        ).to_return(
          body: fixture(:friendships),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource' do
        @client.friendships(1234, 4567)
        expect(a_get('/friendships/lookup.json').with(
          query: {
            user_id: '1234,4567',
          }
        )).to have_been_made
      end
    end

    context 'when multiple String and Integer are passed' do
      before do
        stub_get('/friendships/lookup.json').with(
          query: {
            user_id: '1234,4567',
            screen_name: 'wktk,croudia',
          }
        ).to_return(
          body: fixture(:friendships),
          headers: { content_type: 'application/json; charset=utf-8' }
        )
      end

      it 'requests the correct resource' do
        @client.friendships('wktk', 1234, 'croudia', 4567)
        expect(a_get('/friendships/lookup.json').with(
          query: {
            screen_name: 'wktk,croudia',
            user_id: '1234,4567',
          }
        )).to have_been_made
      end
    end
  end

  describe '#friend_ids' do
    before do
      stub_get('/friends/ids.json').with(query: {
        screen_name: 'wktk',
      }).to_return(
        body: fixture(:ids_with_cursor),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.friend_ids('wktk')
      expect(a_get('/friends/ids.json').with(query: {
        screen_name: 'wktk',
      })).to have_been_made
    end

    it 'returns Croudia::Cursor' do
      subject = @client.friend_ids('wktk')
      expect(subject).to be_a Croudia::Cursor
    end

    it 'cursor responds to ids' do
      subject = @client.friend_ids('wktk')
      expect(subject.respond_to?(:ids)).to be_true
    end
  end

  describe '#follower_ids' do
    before do
      stub_get('/followers/ids.json').with(query: {
        screen_name: 'wktk',
      }).to_return(
        body: fixture(:ids_with_cursor),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.follower_ids('wktk')
      expect(a_get('/followers/ids.json').with(query: {
        screen_name: 'wktk',
      })).to have_been_made
    end

    it 'returns Croudia::Cursor' do
      subject = @client.follower_ids('wktk')
      expect(subject).to be_a Croudia::Cursor
    end

    it 'cursor responds to ids' do
      subject = @client.follower_ids('wktk')
      expect(subject.respond_to?(:ids)).to be_true
    end
  end

  describe '#friends' do
    before do
      stub_get('/friends/list.json').with(query: {
        screen_name: 'wktk',
      }).to_return(
        body: fixture(:users_with_cursor),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.friends('wktk')
      expect(a_get('/friends/list.json').with(query: {
        screen_name: 'wktk',
      })).to have_been_made
    end

    it 'returns Croudia::Cursor' do
      subject = @client.friends('wktk')
      expect(subject).to be_a Croudia::Cursor
    end

    it 'cursor responds to users' do
      subject = @client.friends('wktk')
      expect(subject.respond_to?(:users)).to be_true
    end
  end

  describe '#followers' do
    before do
      stub_get('/followers/list.json').with(query: {
        screen_name: 'wktk',
      }).to_return(
        body: fixture(:users_with_cursor),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.followers('wktk')
      expect(a_get('/followers/list.json').with(query: {
        screen_name: 'wktk',
      })).to have_been_made
    end

    it 'returns Croudia::Cursor' do
      subject = @client.followers('wktk')
      expect(subject).to be_a Croudia::Cursor
    end

    it 'cursor responds to users' do
      subject = @client.followers('wktk')
      expect(subject.respond_to?(:users)).to be_true
    end
  end
end
