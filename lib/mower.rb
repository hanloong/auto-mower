class Mower
  attr_accessor :x, :y, :direction, :path
  attr_reader :errors

  DIRECTIONS = ['N', 'E', 'S', 'W']

  def initialize(options = {})
    self.x = options[:x]
    self.y = options[:y]
    self.direction = options[:direction]
    self.path = options[:path]
  end

  def valid?
    self.errors = []
    validate
    errors.empty?
  end

  def pos
    "#{x} #{y}"
  end

  def full_pos
    "#{pos} #{direction}"
  end

  def move(action)
    if action == 'M'
      new_x, new_y = forward
      "#{new_x} #{new_y} #{direction}"
    elsif action == 'L'
      "#{x} #{y} #{left}"
    elsif action == 'R'
      "#{x} #{y} #{right}"
    end
  end

  def move!
    original = full_pos
    if path.any?
      update(move(path.first))
      if valid?
        path.shift
      else
        update(original)
      end
    end
  end

  def move_with_action!(action)
    update(move(action))
  end

  def complete?
    path.empty?
  end

  # Assume its only moving either one square along x or y
  def move_to(pos_x, pos_y)
    diff_x, diff_y = diff(pos_x, pos_y)
    if north?
      if diff_x > 0
        'RM'
      elsif diff_x < 0
        'LM'
      elsif diff_y > 0
        'M'
      elsif diff_y < 0
        'RRM'
      end
    elsif east?
      if diff_x > 0
        'M'
      elsif diff_x < 0
        'RRM'
      elsif diff_y > 0
        'LM'
      elsif diff_y < 0
        'RM'
      end
    elsif south?
      if diff_x > 0
        'LM'
      elsif diff_x < 0
        'RM'
      elsif diff_y > 0
        'RRM'
      elsif diff_y < 0
        'M'
      end
    elsif west?
      if diff_x > 0
        'RRM'
      elsif diff_x < 0
        'M'
      elsif diff_y > 0
        'RM'
      elsif diff_y < 0
        'LM'
      end
    end
  end

  private

  attr_writer :errors

  def diff(x2, y2)
    return (x2 - x), (y2 - y)
  end

  def update(pos_str)
    parts = pos_str.split(' ')
    self.x = parts[0].to_i
    self.y = parts[1].to_i
    self.direction = parts[2]
  end

  def validate
    validate_pos('x', x)
    validate_pos('y', y)
    validate_direction
  end

  def validate_pos(name, value)
    unless is_int?(value)
      errors << "#{name}, is not an integer" and return
    end
    errors << "#{name}, must be positive" if value < 0
  end

  def validate_direction
    unless DIRECTIONS.include?(direction)
      errors << "#{direction} is not a valid direction"
    end
  end

  def forward
    case direction
    when 'N' then return x, y + 1
    when 'E' then return x + 1, y
    when 'S' then return x, y - 1
    when 'W' then return x - 1, y
    end
  end

  def right
    index = DIRECTIONS.find_index(direction)
    if index == (DIRECTIONS.count - 1)
      DIRECTIONS[0]
    else
      DIRECTIONS[index + 1]
    end
  end

  def left
    index = DIRECTIONS.find_index(direction)
    if index == 0
      DIRECTIONS[DIRECTIONS.count - 1]
    else
      DIRECTIONS[index - 1]
    end
  end

  def is_int?(val)
    Integer val rescue false
  end

  def north?
    self.direction == 'N'
  end

  def east?
    self.direction == 'E'
  end

  def west?
    self.direction == 'W'
  end

  def south?
    self.direction == 'S'
  end
end
