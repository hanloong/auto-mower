class Mower < ActiveRecord::Base
  DIRECTIONS = %w(N E S W)

  belongs_to :lawn

  validates_presence_of :x, :y, :heading, :commands
  validates :heading, inclusion: { in: DIRECTIONS,
                                    message: "%{value} is not a valid heading" }

  def self.directions
    DIRECTIONS
  end

  def to_json(options = {})
    super(only: [:id, :x, :y, :heading, :commands])
  end

  def move!
    return false if path.empty?
    self.x, self.y, self.heading = translate(path.first)
    if valid?
      self.commands = path.last(path.count - 1).join
      save
    end
  end

  def complete?
    commands.blank?
  end

  private

  def path
    commands.chars
  end

  def translate(action)
    case action
    when 'M' then forward
    when 'R' then right
    when 'L' then left
    end
  end

  def forward
    case heading
    when 'N' then return x, y + 1, heading
    when 'E' then return x + 1, y, heading
    when 'S' then return x, y - 1, heading
    when 'W' then return x - 1, y, heading
    end
  end

  def right
    index = DIRECTIONS.find_index(heading)
    if index == (DIRECTIONS.count - 1)
      return x, y, DIRECTIONS[0]
    else
      return x, y, DIRECTIONS[index + 1]
    end
  end

  def left
    index = DIRECTIONS.find_index(heading)
    if index == 0
      return x, y, DIRECTIONS[DIRECTIONS.count - 1]
    else
      return x, y, DIRECTIONS[index - 1]
    end
  end
end
