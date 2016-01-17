require 'rails_helper'

describe Mower, type: :model do
  let(:x) { 0 }
  let(:y) { 0 }
  let(:heading) { 'N' }
  let(:commands) { 'RMMLMLMM' }
  let(:subject) { Mower.new x: x, y: y, heading: heading, commands: commands }

  it { should validate_presence_of(:x) }
  it { should validate_presence_of(:y) }
  it { should validate_presence_of(:heading) }
  it { should validate_presence_of(:commands) }
  it { should validate_inclusion_of(:heading).in_array(Mower.directions) }

  describe '#move!' do
    it 'should move the mower' do
      subject.move!
      expect(subject.heading).to eq('E')
      expect(subject.commands.length).to eq(commands.length - 1)
      subject.move!
      expect(subject.x).to eq(1)
    end
  end

  describe '#complete?' do
    it 'should be false when there work to be done' do
      expect(subject.complete?).to be_falsey
    end

    context 'when nothing left' do
      let(:commands) { "" }
      it 'should be complete?' do
        expect(subject.complete?).to be_truthy
      end
    end
  end
end
