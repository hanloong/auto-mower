require 'pry'

class Parser
  attr_accessor :data

  def initialize(data)
    self.data = data
  end

  def lawn_size
    pos = rows.first.split(' ').map(&:to_i)
    {
      width: pos.first,
      height: pos.last
    }
  end

  def mower_count
    (rows.count - 1) / 2
  end

  def mowers
    @mowers ||= pairs.map do |p|
      Mower.new build_pos(p.first).merge(path: p.last.chars)
    end
  end

  private

  def build_pos(val)
    x, y, dir = val.split(' ')
    {x: x.to_i, y: y.to_i, direction: dir}
  end

  def pairs
    @paris ||= tail.each_slice(2).to_a
  end

  def tail
    @tail ||= rows.last(rows.size - 1)
  end

  def rows
    @rows ||= data.split("\n")
  end
end
