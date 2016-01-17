require_relative '../lib/parser'

describe Parser do
  let(:input) { valid_input }
  let(:subject) { Parser.new(input) }

  it 'should init with raw input data' do
    expect(subject.data).to eq input
  end

  describe '#lawn_size' do
    it 'should return a tuple of width height' do
      expect(subject.lawn_size).to eq({width: 5, height: 5})
    end
  end

  describe '#mower_count' do
    it 'should return number of mowers' do
      expect(subject.mower_count).to eq 2
    end
  end

  describe '#mowers' do
    let(:mower_hash) do
        {
          x: 1,
          y: 2,
          direction: 'N',
          path: %w(L M L M L M L M M)
        }
    end
    it 'should return multiple rows' do
      expect(subject.mowers.count).to eq 2
    end

    it 'should return formatted mower string' do
      mower = subject.mowers.first
      expect(mower).to eq mower_hash
    end
  end

  def valid_input
    <<-EOS.gsub(/^ {6}/, '')
      5 5
      1 2 N
      LMLMLMLMM
      3 3 E
      MMRMMRMRRM
    EOS
  end
end
