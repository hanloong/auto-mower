class Mower < ActiveRecord::Base
  belongs_to :lawn

  validates_presence_of :x, :y, :heading, :commands
end
