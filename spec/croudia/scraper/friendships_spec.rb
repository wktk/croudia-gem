require 'helper'

describe Croudia::Scraper::Friendships do
  context 'when logged in' do
    before do
      @croudia = Croudia::Scraper.new
      @croudia.instance_variable_set('@logged_in', true)
    end

    describe '#follow' do
      it 'posts to the correct resource' do
        stub_post('/follows/target_follow').to_return(:headers => {:content_type => 'text/html'})
        @croudia.follow('wktk')
        a_post('/follows/target_follow').with(:body => /target_user_name=wktk/).should have_been_made
      end
    end

    describe '#unfollow' do
      it 'posts to the correct resource' do
        stub_post('/follows/target_follow').to_return(:headers => {:content_type => 'text/html'})
        @croudia.follow('wktk')
        a_post('/follows/target_follow').with(:body => /target_user_name=wktk/).should have_been_made
      end
    end

    describe '#approve' do
      it 'posts to the correct resource' do
        stub_post('/follows/follow_approve').to_return(:headers => {:content_type => 'text/html'})
        @croudia.approve('wktk')
        a_post('/follows/follow_approve').with(:body => /target_user_name=wktk/).should have_been_made
      end
    end

    describe '#refusal' do
      it 'posts to the correct resource' do
        stub_post('/follows/follow_refusal').to_return(:headers => {:content_type => 'text/html'})
        @croudia.refusal('wktk')
        a_post('/follows/follow_refusal').with(:body => /target_user_name=wktk/).should have_been_made
      end
    end

    describe '#block' do
      it 'posts to the correct resource' do
        stub_post('/blocks/setting').to_return(:headers => {:content_type => 'text/html'})
        @croudia.block('wktk')
        a_post('/blocks/setting').with(:body => /target_user_name=wktk/).should have_been_made
      end
    end

    describe '#unblock' do
      it 'posts to the correct resource' do
        stub_post('/blocks/setting').to_return(:headers => {:content_type => 'text/html'})
        @croudia.unblock('wktk')
        a_post('/blocks/setting').with(:body => /target_user_name=wktk/).should have_been_made
      end
    end
  end

  context 'when not logged in' do
    before do
      @croudia = Croudia::Scraper.new
      @croudia.instance_variable_set('@logged_in', false)
    end

    describe '#follow' do
      it 'raises an error' do
        expect{ @croudia.follow('wktk') }.to raise_error Croudia::NotLoggedInError
      end
    end

    describe '#unfollow' do
      it 'raises an error' do
        expect{ @croudia.follow('wktk') }.to raise_error Croudia::NotLoggedInError
      end
    end

    describe '#approve' do
      it 'raises an error' do
        expect{ @croudia.approve('wktk') }.to raise_error Croudia::NotLoggedInError
      end
    end

    describe '#refusal' do
      it 'raises an error' do
        expect{ @croudia.refusal('wktk') }.to raise_error Croudia::NotLoggedInError
      end
    end
  end

  describe '#follower' do
    it 'gets the correct resource' do
      stub_get('/follows/follower/wktk').to_return(:headers => {:content_type => 'text/html'})
      Croudia::Scraper.new.follower('wktk')
      a_get('/follows/follower/wktk').should have_been_made
    end
  end

  describe '#following' do
    it 'gets the correct resource' do
      stub_get('/follows/following/wktk').to_return(:headers => {:content_type => 'text/html'})
      Croudia::Scraper.new.following('wktk')
      a_get('/follows/following/wktk').should have_been_made
    end
  end

  describe '#follow_request' do
    it 'gets the correct resource' do
      stub_get('/follows/follow_request').to_return(:headers => {:content_type => 'text/html'})
      @croudia = Croudia::Scraper.new
      @croudia.instance_variable_set('@logged_in', true)
      @croudia.follow_request
      a_get('/follows/follow_request').should have_been_made
    end
  end
end
