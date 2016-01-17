class Lawn < ActiveRecord::Base
  has_many :mowers, dependent: :destroy

  validates_presence_of :width, :height
  validates_numericality_of :width, greater_than: 0
  validates_numericality_of :height, greater_than: 0

  def to_json(options = {})
    super(only: [:id, :width, :height],
          include: [
            mowers: {only: [:id, :x ,:y, :heading, :commands]}
          ])
  end

  def mow!
    until terminate? do
      move!
    end
  end

  private

  def terminate?
    complete? || mower_errors?
  end

  def complete?
    !mowers.map(&:complete?).include?(false)
  end

  def move!
    mowers.each { |m| m.move! }
  end

  def mower_errors?
    collision || out_of_bounds
    errors.any?
  end

  def collision
    if mowers.map(&:pos).uniq.count < mowers.size
      errors.add :base, 'Oops, looks like two mowers ran into each other'
    end
  end

  def out_of_bounds
    if mowers.select { |m| m.x > width || m.y > height }.any?
      errors.add :base, 'Oops, looks like a mower ran off the lawn'
    end
  end
end
