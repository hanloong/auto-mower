require 'rails_helper'

describe Lawn, type: :model do
  it { should validate_presence_of(:width) }
  it { should validate_presence_of(:height) }
  it { should validate_numericality_of(:width) }
  it { should validate_numericality_of(:height) }
end
