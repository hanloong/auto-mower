require 'pry'

class Parser
  attr_accessor :data

  def initialize(data)
    self.data = data
  end

  def lawn_size
    rows.first.split(' ').map(&:to_i)
  end

  def mower_count
    (rows.count - 1)/2
  end

  def mowers
    pairs.map do |m|
      {
        start: m.first.gsub(/ /, ','),
        path: m.last.chars
      }
    end
  end

  private

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
