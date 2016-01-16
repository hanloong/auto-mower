require_relative '../lib/mower'

describe Mower do
  let(:x) { 0 }
  let(:y) { 1 }
  let(:direction) { 'N' }
  let(:subject) { Mower.new(x: x, y: y, direction: direction) }

  it 'should initialise with positions' do
    expect(subject.x).to eq(0)
    expect(subject.y).to eq(1)
    expect(subject.direction).to eq('N')
  end

  describe '#valid?' do
    it 'should be valid with the correct inputs' do
      expect(subject.valid?).to be_truthy
    end
  end

  describe '#pos' do
    it 'should return a string representation of the mowers position' do
      expect(subject.pos).to eq '0,1'
    end
  end

  describe '#pos_with_direction' do
    it 'should return the postion with direction' do
      expect(subject.full_pos).to eq '0,1,N'
    end
  end

  describe '#move' do
    it 'should return the position after move' do
      expect(subject.move('R')).to eq '0,1,E'
      expect(subject.move('M')).to eq '0,2,N'
      expect(subject.move('L')).to eq '0,1,W'
    end
  end
end
