require 'helper'

describe Croudia::User do
  describe '#==' do
    it 'returns true when objects IDs are the same' do
      user = Croudia::User.new('id' => 1, 'name' => 'hoge')
      other = Croudia::User.new('id' => 1, 'name' => 'fuga')
      expect(user == other).to be_true
    end

    it 'returns false when objects IDs are different' do
      user = Croudia::User.new('id' => 1)
      other = Croudia::User.new('id' => 2)
      expect(user == other).to be_false
    end

    it 'returns false when classes are different' do
      user = Croudia::User.new('id' => 1)
      other = Croudia::Identity.new('id' => 1)
      expect(user == other).to be_false
    end
  end

  describe '#created_at' do
    it 'returns a Time' do
      user = Croudia::User.new('id' => 3, 'created_at' => 'Mon, 08 2013 01:23:45 +0900')
      expect(user.created_at).to be_a Time
    end
  end
end
