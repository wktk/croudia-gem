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
  end

  context 'when not logged in' do
    before do
      @croudia = Croudia::Scraper.new
      @croudia.instance_variable_set('@logged_in', true)
    end

    describe '#follow' do
      it 'should raise error' do
        expect{ @croudia.follow('wktk') }.to raise_error 
      end
    end

    describe '#unfollow' do
      it 'should raise error' do
        expect{ @croudia.follow('wktk') }.to raise_error
      end
    end
  end

  describe '#follower' do
    it 'gets the correct resource' do
      stub_get('/follows/follower/wktk').to_return(:headers => {:content_type => 'text/html'})
      Croudia.follower('wktk')
      a_get('/follows/follower/wktk').should have_been_made
    end
  end

  describe '#following' do
    it 'gets the correct resource' do
      stub_get('/follows/following/wktk').to_return(:headers => {:content_type => 'text/html'})
      Croudia.following('wktk')
      a_get('/follows/following/wktk').should have_been_made
    end
  end
end
