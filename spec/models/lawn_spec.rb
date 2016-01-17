require 'rails_helper'

describe Lawn, type: :model do
  let(:width) { 3 }
  let(:height) { 4 }
  let(:mower) { Mower.new(x: 1, y: 2) }
  let(:another_mower) { Mower.new(x: 2, y: 2) }
  let(:mowers) { [mower, another_mower] }
  let(:subject) { Lawn.new width: width, height: height, mowers: mowers }

  it { should validate_presence_of(:width) }
  it { should validate_presence_of(:height) }
  it { should validate_numericality_of(:width) }
  it { should validate_numericality_of(:height) }

  describe '#mow!' do
    let(:pos1) { '1 2' }
    let(:pos2) { '2 2' }

    before do
      allow(mower).to receive(:complete?).and_return(false, false, true)
      allow(another_mower).to receive(:complete?).and_return(false, false, true)
      allow(mower).to receive(:pos).and_return pos1
      allow(another_mower).to receive(:pos).and_return pos2
    end

    it 'should call move 2 times' do
      expect(mower).to receive(:move!).twice
      expect(another_mower).to receive(:move!).twice
      subject.mow!
    end

    context 'when there\'s a collision' do
      let(:pos1) { '2 2' }
      let(:pos2) { '2 2' }

      it 'should not call move' do
        expect(mower).not_to receive(:move!)
        expect(another_mower).not_to receive(:move!)
        subject.mow!
      end
    end

    context 'when a mower goes nuts' do
      let(:mower) { Mower.new(x: 11, y: 2) }
      let(:another_mower) { Mower.new(x: 2, y: 2) }

      it 'should not call move' do
        expect(mower).not_to receive(:move!)
        expect(another_mower).not_to receive(:move!)
        subject.mow!
      end
    end
  end
end
