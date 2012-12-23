require 'helper'

describe Croudia::Scraper::Login do
  describe '#login' do
    before do
      stub_get('/').to_return do |request|
        if /logged_in=yes/ =~ request.headers['Cookie']
          {:status => 302, :headers => {:location => Croudia.endpoint + '/logged_in'}}
        else
          {:headers => {:content_type => 'text/html'}}
        end
      end
      stub_post('/').to_return do |request|
        headers = {:content_type => 'text/html'}
        if /username=username/ =~ request.body
          headers.merge!(:set_cookie => 'logged_in=yes')
        end
        {:headers => headers}
      end
      stub_get('/logged_in').to_return(:headers => {:content_type => 'text/html'})
    end

    it 'gets "/" before login' do
      Croudia::Scraper.new.login('username', 'password')
      a_get('/').should have_been_made.twice
    end

    it 'posts the provided username and password to "/"' do
      Croudia::Scraper.new.login('username', 'password')
      a_post('/').with(:body => /username=username/).should have_been_made
    end

    it 'checks if succeeded or not' do
      Croudia::Scraper.new.login('username', 'password')
      a_get('/').with(:headers => {:cookie => /logged_in=yes/}).should have_been_made
    end

    context 'when the provided username and password are correct' do
      it 'does not raise an error' do
        expect{ Croudia::Scraper.new.login('username', 'password') }.not_to raise_error
      end

      it 'sets @logged_in as true' do
        @croudia = Croudia::Scraper.new
        @croudia.login('username', 'password')
        @croudia.instance_variable_get('@logged_in').should be_true
      end
    end

    context 'when the provided username and password are incorrect' do
      it 'raises an error' do
        expect{ Croudia::Scraper.new.login('wrong', 'wrong') }.to raise_error ArgumentError
      end
    end
  end

  describe '#logout' do
    context 'when already logged out' do
      it 'raises an error' do
        @croudia = Croudia::Scraper.new
        @croudia.instance_variable_set('@logged_in', false)
        expect{ @croudia.logout }.to raise_error Croudia::NotLoggedInError
      end
    end

    context 'when logged in' do
      before do
        stub_post('/login/logout')
        @croudia = Croudia::Scraper.new
        @croudia.instance_variable_set('@logged_in', true)
      end

      it 'posts a request to the correct resource' do
        @croudia.logout
        a_post('/login/logout').should have_been_made
      end

      it 'sets @logged_in as false' do
        @croudia.logout
        @croudia.instance_variable_get('@logged_in').should be_false
      end

      it 'sets @current_user nil' do
        @croudia.logout
        @croudia.instance_variable_get('@current_user').should be_nil
      end
    end
  end

  describe '#logged_in?' do
    context 'when @logged_in is set' do
      it 'returns @logged_in' do
        @croudia = Croudia::Scraper.new
        @croudia.instance_variable_set('@logged_in', true)
        @croudia.logged_in?.should be_true
        @croudia.instance_variable_set('@logged_in', false)
        @croudia.logged_in?.should be_false
      end
    end

    context 'when @logged_in is not set' do
      it 'gets "/" to confirm logged-in or not' do
        stub_get('/')
        Croudia::Scraper.new.logged_in?
        a_get('/').should have_been_made
      end
    end
  end

  describe '#logged_out?' do
    it 'returns !self.logged_in' do
      @croudia = Croudia::Scraper.new
      @croudia.instance_variable_set('@logged_in', true)
      @croudia.logged_out?.should be_false
      @croudia.instance_variable_set('@logged_in', false)
      @croudia.logged_out?.should be_true
    end
  end

  describe '#require_login' do
    context 'when logged out' do
      it 'raises an errror' do
        @croudia = Croudia::Scraper.new
        @croudia.instance_variable_set('@logged_in', false)
        expect{ @croudia.require_login }.to raise_error Croudia::NotLoggedInError
      end
    end

    context 'when logged in' do
      it 'does not raise an error' do
        @croudia = Croudia::Scraper.new
        @croudia.instance_variable_set('@logged_in', true)
        expect{ @croudia.require_login }.not_to raise_error
      end
    end
  end
end
