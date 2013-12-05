require 'helper'

describe Croudia::API::Trends do
  before do
    @client = Croudia::Client.new
  end

  describe '#trends' do
    before do
      stub_get('/trends/place.json').with(
        query: { id: '1' }
      ).to_return(
        body: fixture(:trends),
        headers: { content_type: 'application/json; chrset=utf-8' }
      )
    end

    it 'requests the correct resource' do
      @client.trends
      expect(a_get('/trends/place.json').with(
        query: { id: '1' }
      )).to have_been_made
    end

    it 'returns TrendResults object' do
      expect(@client.trends).to be_a Croudia::TrendResults
    end
  end
end
