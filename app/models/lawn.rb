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
end
