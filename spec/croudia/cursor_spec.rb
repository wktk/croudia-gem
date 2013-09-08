require 'helper'

describe Croudia::Cursor do
  it 'defines a method to access data' do
    cursor = Croudia::Cursor.new(:hoge, nil, {'hoge' => 'ok'})
    expect(cursor.hoge).to eq 'ok'
  end

  it 'converts each data into instance of given class name' do
    cursor = Croudia::Cursor.new(:data, Time, {'data' => [1,2,3,4]})
    cursor.data.each { |obj| expect(obj).to be_an Time }
  end

  describe '#first?' do
    it 'returns true if previous_cursor is 0' do
      cursor = Croudia::Cursor.new(:data, nil, {'previous_cursor' => 0})
      expect(cursor.first?).to be_true
    end

    it 'returns false if previous_cursor is not 0' do
      cursor = Croudia::Cursor.new(:data, nil, {'previous_cursor' => 5})
      expect(cursor.first?).to be_false
    end
  end

  describe '#last?' do
    it 'returns true if next_cursor is 0' do
      cursor = Croudia::Cursor.new(:data, nil, {'next_cursor' => 0})
      expect(cursor.last?).to be_true
    end

    it 'returns false if next_cursor is not 0' do
      cursor = Croudia::Cursor.new(:data, nil, {'next_cursor' => 5})
      expect(cursor.last?).to be_false
    end
  end
end
