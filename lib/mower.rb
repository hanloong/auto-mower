class Mower
  attr_accessor :x, :y, :direction
  attr_reader :errors

  def initialize(options = {})
    self.x = options[:x]
    self.y = options[:y]
    self.direction = options[:direction]
  end

  def valid?
    validate
    errors.nil? || errors.empty?
  end

  def pos
    "#{x},#{y}"
  end

  def full_pos
    "#{pos},#{direction}"
  end

  def move(action)
    if action == 'M'
      case direction
      when 'N'
        "#{x},#{y+1},#{direction}"
      when 'E'
        "#{x+1},#{y},#{direction}"
      when 'S'
        "#{x},#{y-1},#{direction}"
      when 'W'
        "#{x-1},#{y},#{direction}"
      end
    elsif action == 'L'
      case direction
      when 'N' then "#{x},#{y},W"
      when 'E' then "#{x},#{y},N"
      when 'S' then "#{x},#{y},W"
      when 'W' then "#{x},#{y},S"
      end
    elsif action == 'R'
      case direction
      when 'N' then "#{x},#{y},E"
      when 'E' then "#{x},#{y},S"
      when 'S' then "#{x},#{y},W"
      when 'W' then "#{x},#{y},N"
      end
    end
  end

  private

  attr_writer :errors

  def validate
  end
end
