require_relative 'mower'

class Lawn
  attr_accessor :mowers, :width, :height

  def initialize(options = {})
    self.width = options[:width]
    self.height = options[:height]
    self.mowers = options[:mowers] || []
  end

  def mow!
    until complete? || error? do
      move!
    end
  end

  def output
    mowers.map(&:full_pos)
  end

  private

  def complete?
    !mowers.map(&:complete?).include?(false)
  end

  def move!
    mowers.each { |m| m.move! }
  end

  def error?
    collision? || out_of_bounds?
  end

  def collision?
    mowers.map(&:pos).uniq.count < mowers.count
  end

  def out_of_bounds?
    mowers.select { |m| m.x > width || m.y > height }.any?
  end
end
