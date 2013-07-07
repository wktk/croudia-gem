require 'helper'

describe Croudia::Status do
  describe '#==' do
    it 'returns true when objects IDs are the same' do
      status = Croudia::Status.new(id: 1, text: 'hoge')
      other = Croudia::Status.new(id: 1, text: 'fuga')
      expect(status == other).to be_true
    end

    it 'returns false when objects IDs are different' do
      status = Croudia::Status.new(id: 1)
      other = Croudia::Status.new(id: 2)
      expect(status == other).to be_false
    end

    it 'returns false when classes are different' do
      status = Croudia::Status.new(id: 1)
      other = Croudia::Identity.new(id: 1)
      expect(status == other).to be_false
    end
  end

  describe '#created_at' do
    it 'returns a Time' do
      status = Croudia::Status.new(id: 3, created_at: 'Mon, 08 Jul 2013 01:23:45 +0900')
      expect(status.created_at).to be_a Time
    end
  end
end
