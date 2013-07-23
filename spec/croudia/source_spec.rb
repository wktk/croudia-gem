require 'helper'

describe Croudia::Source do
  describe '#==' do
    it 'returns true when name and url are same' do
      one = Croudia::Source.new('name' => 'hoge', 'url' => 'https://croudia.com')
      two = Croudia::Source.new('name' => 'hoge', 'url' => 'https://croudia.com')
      expect(one == two).to be_true
    end

    it 'returns false when name is different' do
      one = Croudia::Source.new('name' => 'hoge', 'url' => 'https://croudia.com')
      two = Croudia::Source.new('name' => 'fuga', 'url' => 'https://croudia.com')
      expect(one == two).to be_false
    end

    it 'returns false when url is different' do
      one = Croudia::Source.new('name' => 'hoge', 'url' => 'https://croudia.com')
      two = Croudia::Source.new('name' => 'hoge', 'url' => 'http://croudia.co.jp')
      expect(one == two).to be_false
    end

    it 'returns false when url and name are different' do
      one = Croudia::Source.new('name' => 'hoge', 'url' => 'https://croudia.com')
      two = Croudia::Source.new('name' => 'fuga', 'url' => 'http://croudia.co.jp')
      expect(one == two).to be_false
    end
  end

  describe '#to_s' do
    it 'returns name' do
      obj = Croudia::Source.new('name' => 'source_name', 'url' => 'https://croudia.com')
      expect(obj.to_s).to eq 'source_name'
    end
  end
end
