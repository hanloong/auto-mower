class Mower < ActiveRecord::Base
  belongs_to :lawn

  validates_presence_of :x, :y, :heading, :commands

  def to_json(options = {})
    super(only: [:id, :x, :y, :heading, :commands])
  end
end
