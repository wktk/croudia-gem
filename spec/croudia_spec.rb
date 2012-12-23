require 'helper'

describe Croudia do
  context 'when delegating to Croudia::Scraper' do
    before do
      stub_get('/wktk').to_return(:body => fixture('user_wktk1'),
        :headers => { :content_type => 'text/html' })
    end

    it 'should get the correct resource' do
      Croudia.user('wktk')
      a_get('/wktk').should have_been_made
    end

    it 'returns the same result to Croudia::Scraper' do
      Croudia.user('wktk').should eq Croudia::Scraper.new.user('wktk')
    end
  end

  describe '.scraper' do
    it 'returns a Croudia::Scraper' do
      Croudia.scraper.should be_a Croudia::Scraper
    end
  end

  describe '.new' do
    it 'returns a Croudia::Scraper' do
      Croudia.new.should be_a Croudia::Scraper
    end
  end

  describe '.client' do
    it 'returns a Croudia::Scraper' do
      Croudia.client.should be_a Croudia::Scraper
    end
  end

  describe '.respond_to?' do
    it 'delegates to Croudia::Scraper' do
      Croudia.respond_to?(:user).should be_true
    end
  end

  describe '.endpoint' do
    it 'returns the default endpoint' do
      Croudia.endpoint.should eq 'https://croudia.com'
    end
  end
end
