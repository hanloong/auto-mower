require_relative '../lib/lawn'

describe Lawn do
  let(:width) { 3 }
  let(:height) { 4 }
  let(:mower) { double('Mower') }
  let(:another_mower) { double('Mower') }
  let(:mowers) { [mower, another_mower] }
  let(:subject) { Lawn.new width: width, height: height, mowers: mowers }

  it 'should initialise with valid properties' do
    expect(subject.width).to eq width
    expect(subject.height).to eq height
    expect(subject.mowers.count).to eq 2
  end

  describe '#mow!' do

  end
end
