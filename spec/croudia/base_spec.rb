require 'helper'

describe Croudia::Base do
  before do
    @base = Croudia::Base.new(id: 1)
  end

  describe '#[]' do
    it 'calls methods using [] with symbol' do
      expect(@base[:object_id]).to be_an Integer
    end

    it 'calls methods using [] with string' do
      expect(@base['object_id']).to be_an Integer
    end

    it 'returns nil for missing method' do
      expect(@base[:a_missing_method_hoge]).to be_nil
    end
  end

  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@base.attrs).to eq({id: 1})
    end
  end
end
