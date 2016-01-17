class Lawn < ActiveRecord::Base
  has_many :mowers

  validates_presence_of :width, :height
  validates_numericality_of :width, greater_than: 0
  validates_numericality_of :height, greater_than: 0
end
