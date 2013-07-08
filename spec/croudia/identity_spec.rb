require 'helper'

describe Croudia::Identity do
  describe '#initialize' do
    it 'raises ArguentError if "id" attr is missing' do
      expect { Croudia::Identity.new }.to raise_error ArgumentError
    end
  end

  describe '#==' do
    it 'returns true when objects IDs are the same' do
      one = Croudia::Identity.new('id' => 1, 'text' => 'hoge')
      two = Croudia::Identity.new('id' => 1, 'text' => 'fuga')
      expect(one == two).to be_true
    end

    it 'returns false when objects IDs are different' do
      one = Croudia::Identity.new('id' => 1)
      two = Croudia::Identity.new('id' => 2)
      expect(one == two).to be_false
    end

    it 'returns false when classes are different' do
      one = Croudia::Identity.new('id' => 1)
      two = Croudia::Base.new('id' => 1)
      expect(one == two).to be_false
    end
  end
end
