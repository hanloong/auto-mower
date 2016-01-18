require_relative '../lib/mower'

describe Mower do
  let(:x) { 0 }
  let(:y) { 1 }
  let(:direction) { 'N' }
  let(:path) { %w(L R M R M) }
  let(:subject) { Mower.new(x: x, y: y, direction: direction, path: path) }

  it 'should initialise with positions' do
    expect(subject.x).to eq(0)
    expect(subject.y).to eq(1)
    expect(subject.direction).to eq('N')
    expect(subject.path).to eq path
  end

  describe '#valid?' do
    it 'should be valid with the correct inputs' do
      expect(subject.valid?).to be_truthy
    end

    context 'with negative x' do
      let(:x) { -1 }
      it { expect(subject.valid?).to be_falsey }
    end

    context 'with non-numeric x' do
      let(:x) { 'abc' }
      it { expect(subject.valid?).to be_falsey }
    end

    context 'with negative y' do
      let(:y) { -1 }
      it { expect(subject.valid?).to be_falsey }
    end

    context 'with non-numeric y' do
      let(:y) { 'abc' }
      it { expect(subject.valid?).to be_falsey }
    end

    context 'with invalid direction' do
      let(:direction) { 'NE' }
      it { expect(subject.valid?).to be_falsey }
    end
  end

  describe '#pos' do
    it 'should return a string representation of the mowers position' do
      expect(subject.pos).to eq '0 1'
    end
  end

  describe '#pos_with_direction' do
    it 'should return the postion with direction' do
      expect(subject.full_pos).to eq '0 1 N'
    end
  end

  describe '#move' do
    it 'should return the position after move' do
      expect(subject.move('R')).to eq '0 1 E'
      expect(subject.move('M')).to eq '0 2 N'
      expect(subject.move('L')).to eq '0 1 W'
    end
  end

  describe '#move!' do
    it 'should move the mower' do
      subject.move!
      expect(subject.full_pos).to eq '0 1 W'
      subject.move!
      expect(subject.full_pos).to eq '0 1 N'
      subject.move!
      expect(subject.full_pos).to eq '0 2 N'
    end
  end
end
