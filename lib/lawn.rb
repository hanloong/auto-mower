class Lawn
  attr_accessor :mowers, :width, :height

  def initialize(options = {})
    self.width = options[:width]
    self.height = options[:height]
    self.mowers = options[:mowers] || []
  end

  def complete?
  end

  def crash?
  end
end
