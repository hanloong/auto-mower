require 'rails_helper'

describe Mower, type: :model do
  it { should validate_presence_of(:x) }
  it { should validate_presence_of(:y) }
  it { should validate_presence_of(:heading) }
  it { should validate_presence_of(:commands) }
end
