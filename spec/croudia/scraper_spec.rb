require 'helper'

describe Croudia::Scraper do
  describe '#initialize' do
    context 'when giving a block' do
      it 'sets instance variables using block' do
        Croudia::Scraper.new { |cr| cr.endpoint = 'http://wktk.in' }.
          endpoint.should eq 'http://wktk.in'
      end

      it 'uses the default setting if not set' do
        Croudia::Scraper.new { |_| }.endpoint.should eq Croudia.endpoint
      end

      it 'sets @user_agent to @agent.user_agent' do
        Croudia::Scraper.new { |cr| cr.user_agent = 'HelloHello!!!' }.user_agent.should eq 'HelloHello!!!'
      end
    end

    context 'when giving arguments' do
      before do
        stub_any('/').to_return(:status => 302, :headers => { :location => Croudia.endpoint + '/voices/timeline' })
        stub_get('/voices/timeline').to_return(:body => '', :headers => {:content_type => 'text/html'})
      end

      it 'logs in using arguments if 2 args provided' do
        Croudia::Scraper.new('username', 'password')
        a_post('/').should have_been_made
      end

      it 'does not log in if args.size is less than 2' do
        Croudia::Scraper.new('username')
        a_post('/').should_not have_been_made
      end
    end
  end

  describe '#get' do
    it 'gets the correct resource' do
      stub_get('/correct_resource').to_return(:headers => {:content_type => 'text/html'})
      Croudia::Scraper.new.get('/correct_resource')
      a_get('/correct_resource').should have_been_made
    end

    it 'can query params' do
      stub_get('/hi?saying=hello').to_return(:headers => {:content_type => 'text/html'})
      Croudia::Scraper.new.get('/hi', :saying => 'hello')
      a_get('/hi?saying=hello').should have_been_made
    end
  end

  describe '#post' do
    it 'posts to the correct resource' do
      stub_post('/correct_resource').to_return(:headers => {:content_type => 'text/html'})
      Croudia::Scraper.new.post('/correct_resource')
      a_post('/correct_resource').should have_been_made
    end

    it 'can query params' do
      stub_post('/hi').to_return(:headers => {:content_type => 'text/html'})
      Croudia::Scraper.new.post('/hi', :saying => 'hello')
      a_post('/hi').with(:body => /saying=hello/).should have_been_made
    end

    it 'adds csrf-token to the query' do
      stub_post('/hi').to_return(:headers => {:content_type => 'text/html'})
      croudia = Croudia::Scraper.new
      croudia.instance_variable_set('@authenticity_token', 'foofoo')
      croudia.post('/hi')
      a_post('/hi').with(:body => /authenticity_token=foofoo/).should have_been_made
    end
  end

  describe '#pick_token' do
    it 'picks the csrf-token if it is defined in the document' do
      stub_get('/wktk').to_return(:body => fixture('user_wktk1'), :headers => {:content_type => 'text/html'})
      croudia = Croudia::Scraper.new
      croudia.get('/wktk')
      croudia.instance_variable_get('@authenticity_token').should eq 'dummy_csrf_token'
    end
  end

  describe '#endpoint' do
    it 'returns the current endpoint' do
      Croudia::Scraper.new.endpoint.should eq 'https://croudia.com'
    end
  end

  describe '#endpoint=' do
    it 'can set self.endpoint' do
      croudia = Croudia::Scraper.new
      croudia.endpoint = 'http://wktk.in'
      croudia.endpoint.should eq 'http://wktk.in'
    end
  end

  describe '#user_agent' do
    it 'returns the current user_agent' do
      Croudia::Scraper.new.user_agent.should eq "The Croudia Gem/#{Croudia::VERSION} (https://github.com/wktk/croudia-gem)"
    end

    it 'is the same value to @agent.user_agent' do
      (c = Croudia::Scraper.new).user_agent.should eq c.agent.user_agent
    end
  end

  describe '#user_agent=' do
    it 'can set self.user_agent' do
      croudia = Croudia::Scraper.new
      croudia.user_agent = 'Foofoo'
      croudia.user_agent.should eq 'Foofoo'
    end

    it 'sets it to @agent.user_agent' do
      croudia = Croudia::Scraper.new
      croudia.user_agent = 'Barbar'
      croudia.agent.user_agent.should eq 'Barbar'
    end
  end
end
