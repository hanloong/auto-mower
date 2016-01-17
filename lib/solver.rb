require_relative 'mower'
require_relative 'lawn'

class Solver
  attr_accessor :width, :height, :mowers_count

  def initialize(options = {})
    self.width = options[:width]
    self.height = options[:height]
    self.mowers_count = options[:mowers_count]
  end

  def solve
    (0...mowers_count).inject([]) do |acc, i|

      start = i * interval
      stop = (i + 1) * interval
      x, y = number_to_pos(start)
      d = optimal_direction_for(x, y)

      acc << {
        start: "#{x} #{y} #{d}",
        path: build_path(x, y, d, ((start+1)...stop).to_a)
      }
    end
  end

  private

  def total_blocks
    width * height
  end

  def interval
    total_blocks / mowers_count
  end

  def pos_to_number(x, y)
    (y * width) + x
  end

  def number_to_pos(num)
    y = (num / width).to_i
    x = if y.even?
      num - (y * width)
    else
      (width - 1) - (num - (y * width))
    end
    return x, y
  end

  def build_path(x, y, d, path)
    mower = Mower.new(x: x, y: y, direction: d)
    path.map do |p|
      new_x, new_y = number_to_pos(p)
      move = mower.move_to(new_x, new_y)
      move.chars.each { |c| mower.move_with_action!(c) }
      move
    end.join
  end

  def optimal_direction_for(x, y)
    if y.even?
      ((x - 1) < width) ? 'E' : 'N'
    else
      x == 0 ? 'N' : 'W'
    end
  end
end
