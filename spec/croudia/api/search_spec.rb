require 'helper'

describe Croudia::API::Search do
  before do
    @client = Croudia::Client.new
  end

  describe '#search' do
    before do
      stub_get('/search/voices.json').with(query: {
        q: 'hoge',
      }).to_return(
        body: fixture(:search_results),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.search('hoge')
      expect(a_get('/search/voices.json').with(query: {
        q: 'hoge',
      })).to have_been_made
    end

    it 'returns Croudia::SearchResults' do
      subject = @client.search('hoge')
      expect(subject).to be_a Croudia::SearchResults
    end
  end

  describe '#search_user' do
    before do
      stub_get('/users/search.json').with(query: {
        q: 'hoge',
      }).to_return(
        body: fixture(:users),
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.search_user('hoge')
      expect(a_get('/users/search.json').with(query: {
        q: 'hoge',
      })).to have_been_made
    end

    it 'returns an array of Croudia::User' do
      subject = @client.search_user('hoge')
      expect(subject).to be_a Array
      subject.each { |user| expect(user).to be_a Croudia::User }
    end
  end
end
