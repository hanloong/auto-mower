require_relative '../lib/solver'

describe Solver do
  let(:width) { 3 }
  let(:height) { 4 }
  let(:mowers_count) { 2 }
  let(:subject) { Solver.new width: width, height: height, mowers_count: mowers_count }

  describe '#solve' do
    it 'should return a bunch of starting positions' do
      paths = subject.solve
      expect(paths.count).to eq 2
      expect(paths.first[:start]).to eq('0 0 E')
      expect(paths.first[:path]).to eq('MMLMLMM')
    end
  end
end
