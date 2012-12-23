require 'helper'

describe Croudia::Voice do
  describe '#to_s' do
    it 'returns "@username: text"' do
      user = Croudia::User.new(:username => 'wktk')
      Croudia::Voice.new(:user => user, :desc => 'Hello!').to_s.should eq '@wktk: Hello!'
    end
  end

  describe '#to_i' do
    it 'returns ID in Integer' do
      Croudia::Voice.new(:id => '10', :desc => 'Hello!').to_i.should eq 10
    end
  end
end
