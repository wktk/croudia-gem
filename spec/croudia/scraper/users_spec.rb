require 'helper'

describe Croudia::Scraper::Users do
  describe '#current_user' do
    context 'when logged in' do
      before do
        @croudia = Croudia::Scraper.new
        @croudia.instance_variable_set('@logged_in', true)
        stub_get('/users/redirect_user').to_return(:body => fixture('user_wktk1'), :headers => {:content_type => 'text/html'})
      end

      it 'gets the correct resource' do
        @croudia.current_user
        a_get('/users/redirect_user').should have_been_made
      end

      it 'returns an object of the current user' do
        @croudia.current_user.should be_a Croudia::User
      end

      it 'caches @current_user' do
        @croudia.current_user
        @croudia.current_user
        a_get('/users/redirect_user').should have_been_made.once
      end

      it 'returns the cached object if exists' do
        @current_user = @croudia.current_user
        @croudia.current_user.object_id.should eq @current_user.object_id
      end

      it 'destroyes the cache when an true argument provided' do
        @croudia.current_user(true)
        a_get('/users/redirect_user').should have_been_made
      end
    end

    context 'when not logged in' do
      it 'raises an error' do
        expect{ Croudia::Scraper.new.current_user }.to raise_error
      end
    end
  end

  describe '#user' do
    context 'when an argument provided' do
      before do
        stub_get('/wktk').to_return(:body => fixture('user_wktk1'), :headers => {:content_type => 'text/html'})
      end

      it 'gets the correct resource' do
        Croudia::Scraper.new.user('wktk')
        a_get('/wktk').should have_been_made
      end

      it 'returns a user object' do
        Croudia::Scraper.new.user('wktk').should be_a Croudia::User
      end
    end

    context 'when arguments not provided' do
      it 'returns @current_user when logged in' do
        @croudia = Croudia::Scraper.new
        @croudia.instance_variable_set('@current_user', Croudia::User.new(:username => 'current_user'))
        @croudia.instance_variable_set('@logged_in', true)
        @croudia.user.to_s.should eq 'current_user'
      end

      it 'raises an error when not logged in' do
        expect{ Croudia::Scraper.new.user }.to raise_error
      end
    end
  end
end
